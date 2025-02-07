import 'package:flutter/material.dart';

Widget myCustomTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  final slideAnimation = Tween<Offset>(
    begin:
        Offset(animation.status == AnimationStatus.reverse ? -1.0 : 1.0, 0.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: animation,
    curve: Curves.easeInOut,
  ));

  return SlideTransition(
    position: slideAnimation,
    child: child,
  );
}
