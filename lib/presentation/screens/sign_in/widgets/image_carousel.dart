import 'package:flutter/material.dart';
import '../../../../utils/app_assets.dart';
import 'curved_image_clipper.dart';

class ImageCarousel extends StatelessWidget {
  const ImageCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    const imagePaths = [
      AppAssets.authImage1,
      AppAssets.authImage2,
      AppAssets.authImage3,
    ];

    return Row(
      children: imagePaths.map((path) {
        final index = imagePaths.indexOf(path);

        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: index == 1 ? 4.0 : 0.0),
            child: ClipPath(
              clipper: _getClipper(index),
              child: Image.asset(
                path,
                fit: BoxFit.cover,
                height: 140,
                color: Colors.grey.shade900.withOpacity(0.5),
                colorBlendMode: BlendMode.darken,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}


CustomClipper<Path> _getClipper(int index) {
  if (index == 0) return LeftImageClipper();
  if (index == 1) return CenterImageClipper();
  return RightImageClipper();
}