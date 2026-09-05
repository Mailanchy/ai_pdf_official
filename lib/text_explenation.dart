import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

import 'package:dio/dio.dart';

class OpenAI {
  Future<String> getDefinition(String query) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
      'Bearer ${dotenv.env['OPENAI_API_KEY']}'
    }; //header of http protocol

    var data = json.encode({
    "model": "gpt-3.5-turbo",
    "messages": [
    {
    "role": "system",
    "content": "We're developing an innovative AI-powered mobile PDF reader designed to enhance the educational experience for students across various disciplines. Our application focuses on revolutionizing how students engage with complex learning materials, particularly within the realm of digital education.At the core of our application lies an intuitive text selection and explanation feature. Users can seamlessly select any portion of text within a PDF – whether it's a word, sentence, or entire paragraph. Once a selection is made, the application displays the selected text alongside an 'Explain' button.Your task is to provide an explanation for the selected text segment in a clear and easily understandable language. The explanation should aim to elucidate the meaning and context of the text segment, ensuring that it is comprehensible to users from diverse educational backgrounds.Please prioritize clarity, conciseness, and accuracy in your response. Remember, the goal is to streamline the learning process and empower students to gain instant clarity without disrupting their study flow.Thank you for your assistance in enriching our application's functionality!"
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
