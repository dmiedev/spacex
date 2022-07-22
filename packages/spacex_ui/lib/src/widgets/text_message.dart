import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    super.key,
    this.title,
    this.text,
    this.textMaxLines,
    this.button,
  });

  final String? title;
  final String? text;
  final int? textMaxLines;
  final Widget? button;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                title!.toUpperCase(),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (text != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: AutoSizeText(
                text!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
                maxLines: textMaxLines,
              ),
            ),
          if (button != null) button!,
        ],
      ),
    );
  }
}
