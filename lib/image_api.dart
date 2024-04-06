import 'dart:convert';
import 'package:dio/dio.dart';

class GenerateImage {
  Future<void> getImage(String definition) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer REMOVED_SECRET'
    };
    var data = json.encode({
      "model": "dall-e-3",
      "prompt": definition,
      "n": 1,
      "size": "1024x1024",
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
      (json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }
}
