import 'package:flutter/material.dart';
import 'package:spacex_ui/src/widgets/widgets.dart';

/// A scrollable widget that displays information divided into sections.
class Article extends StatelessWidget {
  /// Creates a scrollable widget that displays information divided into
  /// sections.
  const Article({
    super.key,
    this.title,
    this.subtitle,
    this.description,
    this.images,
    this.sections,
    this.controller,
  });

  /// The title of this article.
  final String? title;

  /// The subtitle of this article that is displayed in a smaller font above
  /// [title].
  final String? subtitle;

  /// Longer text displayed under [title].
  final ArticleSection? description;

  /// A list of URLs to images that are displayed in a [ImageGallery] above all
  /// content.
  final List<String>? images;

  /// Other information that is divided into sections and displayed under
  /// [description].
  final List<ArticleSection>? sections;

  /// An object that can be used to control the position to which this article
  /// is scrolled.
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
