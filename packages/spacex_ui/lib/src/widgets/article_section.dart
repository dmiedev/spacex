import 'package:flutter/material.dart';
import 'package:spacex_ui/src/widgets/widgets.dart';

/// A section of an [Article].
class ArticleSection extends StatelessWidget {
  /// Creates a section of an [Article].
  const ArticleSection({
    super.key,
    this.title,
    this.body,
    this.bulletedList,
  });

  /// The title of this article.
  final String? title;

  /// The main body of this article.
  final String? body;

  /// A bulleted list of additional links or information displayed under the
  /// [body].
  final List<DetailsSectionBullet>? bulletedList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                title!,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (body != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                body!,
                style: const TextStyle(
                  fontSize: 20,
                  height: 1.5,
                ),
              ),
            ),
          ...?bulletedList,
        ],
      ),
    );
  }
}

/// An item of an [ArticleSection] bulleted list.
class DetailsSectionBullet extends StatelessWidget {
  /// Creates an item of an [ArticleSection] bulleted list.
  const DetailsSectionBullet({
    super.key,
    required this.label,
    this.onTap,
  });

  /// The label that is displayed on this bulleted list item.
  final String label;

  /// Called when the user taps on this bulleted list item.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    const fontSize = 20.0;
    const height = 1.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          '• ',
          style: TextStyle(fontSize: fontSize, height: height),
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            label,
            style: TextStyle(
              decoration: onTap != null
                  ? TextDecoration.underline
                  : TextDecoration.none,
              fontSize: fontSize,
              height: height,
            ),
          ),
        ),
      ],
    );
  }
}
