import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_audio_app/view/universal_widgets/my_image.dart';

class MyNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double? imgHeight;
  final double? imgWidth;
  final BoxFit? fit;
  const MyNetworkImage({
    super.key,
    required this.imageUrl,
    this.imgHeight,
    this.imgWidth,
    required this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: imgWidth,
      height: imgHeight,
      child: CachedNetworkImage(
        imageUrl: "$imageUrl",
        imageBuilder: (context, imageProvider) => Container(
          height: imgHeight,
          width: imgWidth,
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: fit),
          ),
        ),
        placeholder: (context, url) => MyImage(
          imagePath: "ic_placeholder.png",
          fit: fit,
          height: imgHeight,
          width: imgWidth,
        ),
        errorWidget: (context, url, error) => MyImage(
          imagePath: "ic_placeholder.png",
          fit: fit,
          height: imgHeight,
          width: imgWidth,
        ),
      ),
    );
  }
}
