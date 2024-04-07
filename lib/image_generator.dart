import 'dart:convert';

import 'package:dio/dio.dart';

class GenerateImage {
  Future<String?> getAIimage(String definition) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer REMOVED_SECRET'
    };
    var data = json.encode({
      "model": "dall-e-3",
      "prompt": definition,
      "n": 1,
      "size": "512x512",
    });
    var dio = Dio();
    var response = await dio.request(
      'https://api.openai.com/v1/images/generations',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      String encodedData = (json.encode(response.data));
      return json.decode(encodedData)['data'][1]['url'];
    } else {
      return null;
    }
  }

//Google image api function
  Future<List<String?>> getGoogleImage(String definition) async {
    List<String?> link = [];
    var dio = Dio();
    var response = await dio.request(
      'https://serpapi.com/search.json?q=hello&engine=google_images&ijn=0&api_key=REMOVED_SECRET',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      String encodedResponse = json.encode(response.data);
      for (int i = 0; i < 2; i++) {
        link[i] = json.decode(encodedResponse)['images_results'][i]['original'];
      }
      return link;
    } else {
      return []; //empty array representation = []
    }
  }
}
