import 'package:ai_pdf_official/image_description.dart';
import 'package:ai_pdf_official/image_generator.dart';
import 'package:ai_pdf_official/text_explenation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
        color: Colors.white,
        child: Column(
          children: [
            if (widget.selectedText != "") Text(widget.selectedText),
            if (explanation != null) Text(explanation!),
            if (imageLink != null) Image.network(imageLink!),
            Row(
              children: [
                SizedBox(width: 3),
                Expanded(
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF6A0DAD)),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                    ),
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
                ),
                SizedBox(width: 6),
                Expanded(
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF6A0DAD)),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                    ),
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
                    child: Text("Illustrate"),
                  ),
                ),
                SizedBox(width: 6),
                Expanded(
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF6A0DAD)),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                    ),
                    onPressed: () {
                      setState(() {
                        explanation = "";
                      });
                    },
                    child: Text("Clear"),
                  ),
                ),
                SizedBox(width: 3),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
