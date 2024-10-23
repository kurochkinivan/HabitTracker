import 'package:flutter/material.dart';

class Scaling {
  final double screenWidth;
  final double screenHeight;
  static const double baseWidth = 412;
  static const double baseHeight = 812;

  late final double scaleFactorWidth;
  late final double scaleFactorHeight;

  Scaling._(this.screenWidth, this.screenHeight)
      : scaleFactorWidth =
            (screenWidth / baseWidth) * (screenWidth / baseWidth),
        scaleFactorHeight =
            (screenHeight / baseHeight) * (screenHeight / baseHeight);

  static Scaling of(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaling._(size.width, size.height);
  }

  double scaleWidth(double value) => value * scaleFactorWidth;
  double scaleHeight(double value) => value * scaleFactorHeight;

  List<double> scaleBoth(double width, double height) {
    return [scaleWidth(width), scaleHeight(height)];
  }
}
