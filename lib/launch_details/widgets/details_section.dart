import 'package:flutter/material.dart';

class DetailsSection extends StatelessWidget {
  const DetailsSection({
    super.key,
    this.title,
    this.body,
    this.bulletList,
  });

  final String? title;
  final String? body;
  final List<DetailsSectionListItem>? bulletList;

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
          ...?bulletList,
        ],
      ),
    );
  }
}

class DetailsSectionListItem extends StatelessWidget {
  const DetailsSectionListItem({
    required this.label,
    this.onTap,
  });

  final String label;
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
