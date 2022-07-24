import 'package:flutter/material.dart';
import 'package:spacex/l10n/l10n.dart';

/// A scrollable row of [Image]s.
class ImageGallery extends StatelessWidget {
  /// Creates a scrollable row of [Image]s.
  const ImageGallery({
    super.key,
    required this.imageUrls,
  });

  /// URLs of the images displayed in this gallery.
  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return LayoutBuilder(
      builder: (context, constraints) {
        if (imageUrls.isEmpty) {
          return Center(
            child: Text(
              l10n.noImagesAvailableImageGalleryMessage,
              style: const TextStyle(fontSize: 20),
            ),
          );
        } else if (constraints.maxWidth < 600) {
          return Image(
            image: NetworkImage(imageUrls.first),
            fit: BoxFit.fitHeight,
          );
        }
        return ShaderMask(
          blendMode: BlendMode.dstOut,
          shaderCallback: (rect) => const LinearGradient(
            colors: [
              Colors.transparent,
              Colors.black87,
            ],
            stops: [0.9, 1],
          ).createShader(rect),
          child: Center(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: imageUrls.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Image(
                  image: NetworkImage(imageUrls[index]),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
