import 'package:flutter/material.dart';
import 'package:spacex_ui/src/widgets/widgets.dart';

class Article extends StatelessWidget {
  const Article({
    super.key,
    this.title,
    this.subtitle,
    this.description,
    this.images,
    this.sections,
    this.controller,
  });

  final String? title;
  final String? subtitle;
  final ArticleSection? description;
  final List<String>? images;
  final List<ArticleSection>? sections;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: controller,
      children: [
        if (images != null)
          SizedBox(
            height: 400,
            child: ImageGallery(imageUrls: images!),
          ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (subtitle != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    subtitle!,
                    style: const TextStyle(fontSize: 26),
                  ),
                ),
              if (title != null)
                Text(
                  title!,
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
        if (description != null) description!,
        if (sections != null)
          Wrap(
            spacing: 50,
            children: [...sections!],
          ),
        const SizedBox(height: 75),
      ],
    );
  }
}
