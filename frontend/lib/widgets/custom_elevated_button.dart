import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final ValueNotifier<bool>? isLoadingController;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isEnabled,
    this.isLoadingController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ButtonStyle(
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(vertical: 16.h, horizontal: 38.w),
          ),
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              return states.contains(WidgetState.disabled)
                  ? AppColors.grey03
                  : AppColors.black01;
            },
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          textStyle: WidgetStateProperty.resolveWith<TextStyle>(
            (Set<WidgetState> states) {
              return TextStyle(
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                letterSpacing: -0.4,
                height: 1.3,
                color: states.contains(WidgetState.disabled)
                    ? AppColors.grey01
                    : AppColors.white,
              );
            },
          ),
        ),
        child: ValueListenableBuilder<bool>(
          valueListenable: isLoadingController ?? ValueNotifier(false),
          builder: (context, isLoading, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isLoading)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        color: AppColors.white,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                Text(text),
                if (isLoading) const SizedBox(width: 26),
              ],
            );
          },
        ),
      ),
    );
  }
}
