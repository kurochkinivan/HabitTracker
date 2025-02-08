import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onPressed;
  final String? label;

  const CustomAppBar({
    super.key,
    this.onPressed,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: EdgeInsets.only(
          left: 8.w,
          right: 32.w,
        ),
        child: Row(
          children: [
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/arrow_left.svg",
                height: 32.w,
                width: 32.w,
                fit: BoxFit.contain,
              ),
              onPressed: onPressed ?? () => context.router.back(),
            ),
            const Spacer(),
            Text(
              label ?? '',
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(fontSize: 20.sp),
            ),
            const Spacer(),
            SizedBox(width: 20.w),
          ],
        ),
      ),
      toolbarHeight: 88.h,
      backgroundColor: AppColors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(88.h);
}
