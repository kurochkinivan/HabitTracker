import 'package:flutter/material.dart';

class Habit {
  final String name;
  final Color color;
  final String icon;
  final int popularityIndex;

  Habit(
      {required this.name,
      required this.color,
      required this.icon,
      required this.popularityIndex});
}
