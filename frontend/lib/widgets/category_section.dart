import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habit_tracker/app_colors.dart';
import '../models/habits.dart';
import 'habit_item.dart';

class CategorySection extends StatefulWidget {
  final String title;
  final List<Habit> habits;

  const CategorySection({
    super.key,
    required this.title,
    required this.habits,
  });

  @override
  CategorySectionState createState() => CategorySectionState();
}

class CategorySectionState extends State<CategorySection>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _heightAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _heightAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
      if (isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: isExpanded ? AppColors.black02 : AppColors.gray01,
                letterSpacing: -0.4,
              ),
            ),
            IconButton(
              onPressed: _toggleExpansion,
              icon: SvgPicture.asset(
                isExpanded
                    ? 'assets/icons/expand_up.svg'
                    : 'assets/icons/expand_down.svg',
                width: 16.w,
                height: 16.w,
              ),
            ),
          ],
        ),
        ClipRect(
          child: SizeTransition(
            sizeFactor: _heightAnimation,
            axisAlignment: -1.0,
            child: Column(
              children: [
                for (int i = 0; i < widget.habits.length; i++) ...[
                  HabitItem(
                    icon: widget.habits[i].icon,
                    title: widget.habits[i].name,
                    color: widget.habits[i].color,
                  ),
                  if (i < widget.habits.length - 1) SizedBox(height: 10.h),
                ],
              ],
            ),
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
