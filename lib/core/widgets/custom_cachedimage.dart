import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomCachedImage extends StatelessWidget {
  const CustomCachedImage({
    super.key,
    required this.imageUrl,
    this.rounded = true,
    this.loadingAnimation = true,
    this.fixed = true,
  });
  final String imageUrl;
  final bool rounded;
  final bool loadingAnimation;
  final bool fixed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          rounded ? BorderRadius.circular(15) : BorderRadius.circular(0),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fixed ? BoxFit.cover : null,

        // color: ConstantsColors.grey,

        placeholder: (context, url) {
          return loadingAnimation
              ? LoadingAnimationWidget.threeArchedCircle(
                  color: Colors.white,
                  size: 45,
                )
              : Container();
        },
      ),
    );
  }
}
