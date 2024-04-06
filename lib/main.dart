import 'package:ai_pdf_official/explainwidget.dart';
import 'package:ai_pdf_official/pdf_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'bottom_sheet.dart';

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
            ),
          ),
          MyDraggableSheet(passText: passText,)
        ],
      ),
    );
  }
}


