import 'package:ai_pdf_official/image_api.dart';
import 'package:ai_pdf_official/open_ai_api.dart';
import 'package:ai_pdf_official/pdf_view.dart';
import 'package:ai_pdf_official/test_image.dart';
import 'package:flutter/material.dart';

class ExplainWidget extends StatefulWidget {
  ExplainWidget({super.key, required this.selectedText});

  String selectedText;

  @override
  State<ExplainWidget> createState() => _ExplainWidgetState();
}

class _ExplainWidgetState extends State<ExplainWidget> {
  String? explanation;
  String? imageLink;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.grey,
        child: Column(
          children: [
            if (widget.selectedText != "") Text(widget.selectedText),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    OpenAI ai = OpenAI();
                    ai.getDefinition(widget.selectedText).then((response) {
                      setState(() {
                        explanation = response;
                      });
                    });
                  },
                  child: Text("Explain"),
                ),
                TextButton(
                  onPressed: () {
                    ImageDef id = ImageDef();
                    id.getImageDefinition().then((response) {
                      setState(() {
                        explanation = response;
                      });
                    });
                    GenerateImage gi = GenerateImage();
                    if (explanation != null) {
                      gi.getImage(explanation!).then((value) {
                        imageLink = value;
                      });
                    } //if
                  },
                  child: Text("Image"),
                ),
              ],
            ),
            if (explanation != null) Text(explanation!),
            if (imageLink != null) Image.network(imageLink!)
          ],
        ),
      ),
    );
  }
}
