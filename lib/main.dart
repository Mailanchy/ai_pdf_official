import 'dart:typed_data';

import 'package:ai_pdf_official/pdf_view.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

import 'bottom_sheet.dart';
import 'image_description.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String passText = '';
  Uint8List? image;
  ScreenshotController controller = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //to remove the top right corner banner
      home: Stack(
        children: [
          Expanded(
            child: PdfView(
              selectedText: (select) {
                setState(() {
                  passText = select;
                });
              },
              screenshotController: controller,
            ),
          ),
          MyDraggableSheet(
            passText: passText,
            image: image,
          ),
          FloatingActionButton(
            onPressed: () {
              controller.capture().then((value) {
                setState(() {
                  image = value;
                });
              });
            },
          )
        ],
      ),
    );
  }
}
