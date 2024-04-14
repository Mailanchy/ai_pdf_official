import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfView extends StatefulWidget {
  PdfView(
      {super.key,
      required this.selectedText,
      required this.screenshotController});

  ScreenshotController screenshotController;
  Function(String) selectedText;

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Screenshot(
      controller: widget.screenshotController,
      child: SfPdfViewer.asset(
        'assets/test.pdf',
        onTextSelectionChanged: (details) {
          String? str = details.selectedText;
          widget.selectedText(str ?? "");
        },
      ),
    ));
  }
}
