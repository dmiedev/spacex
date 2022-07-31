import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

/// A message with provided text information.
class TextMessage extends StatelessWidget {
  /// Creates a widget that displays a message with provided text information.
  const TextMessage({
    super.key,
    this.title,
    this.text,
    this.useAutoSizeText = true,
    this.textMaxLines,
    this.button,
  });

  /// The title of this message.
  final String? title;

  /// The main body of this message.
  final String? text;

  /// Whether to use [AutoSizeText] for the main body.
  final bool useAutoSizeText;

  /// A maximum number of lines for the message text to span.
  final int? textMaxLines;

  /// A button to display under this message.
  final Widget? button;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
              child: useAutoSizeText
                  ? AutoSizeText(
                      text!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                      maxLines: textMaxLines,
                    )
                  : Text(
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
