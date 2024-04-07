import 'package:ai_pdf_official/image_description.dart';
import 'package:ai_pdf_official/image_generator.dart';
import 'package:ai_pdf_official/text_explenation.dart';
import 'package:flutter/material.dart';

class ExplanationContentWidget extends StatefulWidget {
  ExplanationContentWidget({super.key, required this.selectedText});

  String selectedText;

  @override
  State<ExplanationContentWidget> createState() =>
      _ExplanationContentWidgetState();
}

class _ExplanationContentWidgetState extends State<ExplanationContentWidget> {
  String? explanation;
  String? imageLink;
  List<String?> googleLink = [];

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
                      gi.getAIimage(explanation!).then((value) {
                        imageLink = value;
                        gi.getGoogleImage(explanation!).then((value) {
                          googleLink = value;
                        });
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
