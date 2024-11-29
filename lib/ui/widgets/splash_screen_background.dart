import 'package:aquagoal/ui/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreenBackground extends StatelessWidget {
  const SplashScreenBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);

    ///stack ekta jinishke arektar upre rkahe perfectly
    return Stack(
      children: [
        Image.asset(
          AssetsPath.splashScreenBackground,
          fit: BoxFit.cover,
          height: screenSize.height,
          width: screenSize.width,
        ),
        SafeArea(child: child),

        ///SafeArea used as this widget is not hide over anything like notification bar ....
      ],
    );
  }
}
