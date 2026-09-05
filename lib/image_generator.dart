import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

import 'package:dio/dio.dart';

class GenerateImage {
  Future<String?> getAIimage(String definition) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${dotenv.env['OPENAI_API_KEY']}'
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
      print(json.decode(encodedData)['data'][1]['url']);
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
      'https://serpapi.com/search.json?q=${'Image search: $definition'}&engine=google_images&ijn=0&api_key=${dotenv.env['SERPAPI_KEY']}',
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      String encodedResponse = json.encode(response.data);
      final images =
          json.decode(encodedResponse)['images_results'] as List<dynamic>;
      for (int i = 0; i < images.length; i++) {
        try {
          link.add(
              json.decode(encodedResponse)['images_results'][i]['original']);
        } catch (e) {
          print(e);
        }
      }
      print(link);
      return link;
    } else {
      return []; //empty array representation = []
    }
  }
}
