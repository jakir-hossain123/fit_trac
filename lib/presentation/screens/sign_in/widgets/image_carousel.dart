// ফাইল: lib/pages/sign_in/widgets/image_carousel.dart

import 'package:flutter/material.dart';
import '../../../../utils/app_assets.dart';
import 'curved_image_clipper.dart';
class ImageCarousel extends StatelessWidget {
  const ImageCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    // নিশ্চিত করুন AppAssets এ সঠিক পাথ আছে
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
              clipper: _getClipper(index), // <--- _getClipper() ফাংশন ব্যবহার
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