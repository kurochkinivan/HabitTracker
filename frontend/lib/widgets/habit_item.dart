import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../app_colors.dart';

class HabitItem extends StatelessWidget {
  final String? icon;
  final String title;
  final Color color;

  const HabitItem({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 10.w),
      decoration: BoxDecoration(
        color: AppColors.gray04,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
                child: Image.asset(
              icon ?? "assets/icons/habit_icons/woman_in_lotus_position.png",
              width: 20.w,
              height: 20.w,
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                return Image.asset(
                  "assets/icons/habit_icons/woman_in_lotus_position.png",
                  width: 20.w,
                  height: 20.w,
                );
              },
            )),
          ),
          SizedBox(width: 24.w),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: AppColors.black02),
            ),
          ),
        ],
      ),
    );
  }
}
