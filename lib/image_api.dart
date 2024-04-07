import 'dart:convert';
import 'package:ai_pdf_official/explainwidget.dart';
import 'package:dio/dio.dart';

class GenerateImage {
  Future<String?> getImage(String definition) async {
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
}
