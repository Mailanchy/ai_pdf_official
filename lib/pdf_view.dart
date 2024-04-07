import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfView extends StatelessWidget {
  PdfView({super.key, required this.selectedText});

  Function(String) selectedText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SfPdfViewer.asset(
      'assets/test.pdf',
      onTextSelectionChanged: (details) {
        String? str = details.selectedText;
        selectedText(str ?? "");
      },
    ));
  }
}
