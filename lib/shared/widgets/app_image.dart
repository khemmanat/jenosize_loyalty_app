import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
  });

  final String? imageUrl;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: CachedNetworkImage(
        imageUrl: imageUrl ?? '',
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => const Icon(Icons.error),
        placeholder: (context, url) => const CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
        ),
      ),
    );
  }
}
