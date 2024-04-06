import 'dart:convert';
import 'package:dio/dio.dart';

class OpenAI {
  Future<String> getDefinition(String query) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer REMOVED_SECRET'
    }; //header of http protocol

    var data = json.encode({
      "model": "gpt-3.5-turbo",
      "messages": [
        {
          "role": "system",
          "content": "you are a angry tutor who doesnt love students"
        },
        {"role": "user", "content": query}
      ]
    }); //data of http protocol

    Dio dio = Dio(); //create object for class Dio
    var response = await dio.request(
      'https://api.openai.com/v1/chat/completions',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    ); //waiting for response from openAI

    String encodedResponse = jsonEncode(response.data);
    var decodedResponse = jsonDecode(encodedResponse);
    //the response from openAI can be decoded only after encoding even if it looks stupid outside
    String resultData = decodedResponse['choices'][0]['message']['content'];
    //inorder to access particular value from a map we need to put the key value in []

    return resultData; // the dart automatically wraps the string in future
  }
}
