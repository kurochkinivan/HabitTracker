import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../app_colors.dart';

class HabitItem extends StatelessWidget {
  final String? icon;
  final String title;
  final Color color;
  final String? query;

  const HabitItem({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
    this.query,
  });

  @override
  Widget build(BuildContext context) {
    final queryLower = query?.toLowerCase() ?? "";
    final titleLower = title.toLowerCase();
    final spans = <InlineSpan>[];

    if (queryLower.isNotEmpty && titleLower.contains(queryLower)) {
      int start = 0;
      while (start < titleLower.length) {
        final index = titleLower.indexOf(queryLower, start);
        if (index == -1) {
          spans.add(TextSpan(
            text: title.substring(start),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.black02,
                ),
          ));
          break;
        }
        if (start != index) {
          spans.add(TextSpan(
            text: title.substring(start, index),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.black02,
                ),
          ));
        }

        spans.add(WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.purple,
              borderRadius: BorderRadius.circular(2),
            ),
            child: Text(
              title.substring(index, index + queryLower.length),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.white,
                  ),
            ),
          ),
        ));

        start = index + queryLower.length;
      }
    } else {
      spans.add(TextSpan(
        text: title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.black02,
            ),
      ));
    }

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
            child: RichText(
              text: TextSpan(children: spans),
            ),
          ),
        ],
      ),
    );
  }
}
