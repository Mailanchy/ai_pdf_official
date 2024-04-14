import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class ImageDef {
  Future<String?> getImageDefinition(var x) async {
    // File f = File("lib/test.jpg");
    // var x = await f.readAsBytes();
    //print(base64Encode(x));

    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer REMOVED_SECRET',
    };
    var data = json.encode({
      "model": "gpt-4-vision-preview",
      "messages": [
        {
          "role": "user",
          "content": [
            {
              "type": "text",
              "text": "What’s in this image?",
            },
            {
              "type": "image_url",
              "image_url": {
                "url": "data:image/jpeg;base64,{${base64Encode(x)}}"
                //${} for treating is as a value instead of a string
              }
            }
          ]
        }
      ],
      "max_tokens": 300
    });
    var dio = Dio();
    var response = await dio.request(
      'https://api.openai.com/v1/chat/completions',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      //200 success(just like 404)
      String encodedData = json.encode(response.data);
      var decodedData = json.decode(encodedData);
      print(decodedData['choices'][0]['message']['content']);
      return decodedData['choices'][0]['message']['content'];
    } else {
      return null;
    }
  }
}
