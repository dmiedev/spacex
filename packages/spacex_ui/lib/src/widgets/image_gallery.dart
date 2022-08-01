import 'package:flutter/material.dart';

// TODO(dmiedev): l10n

/// A widget that displays a scrollable row of provided [Image]s or just the
/// first [Image] if the screen is not really wide.
class ImageGallery extends StatelessWidget {
  /// Creates an adaptive [Image] gallery.
  const ImageGallery({
    super.key,
    required this.imageUrls,
  });

  /// URLs of the images displayed in this gallery.
  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (imageUrls.isEmpty) {
          return const Center(
            child: Text(
              'No images available.',
              style: TextStyle(fontSize: 20),
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
              primary: false,
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
