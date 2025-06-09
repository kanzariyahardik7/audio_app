import 'package:flutter/material.dart';

class MyImage extends StatefulWidget {
  final String? imagePath;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Color? color;
  const MyImage({
    super.key,
    required this.imagePath,
    this.height,
    this.width,
    required this.fit,
    this.color,
  });

  @override
  State<MyImage> createState() => _MyImageState();
}

class _MyImageState extends State<MyImage> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      height: widget.height,
      width: widget.width,
      "assets/images/${widget.imagePath}",
      fit: widget.fit,
      color: widget.color,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          height: widget.height,
          width: widget.width,
          "assets/images/ic_placeholder.png",
          fit: widget.fit,
        );
      },
    );
  }
}
