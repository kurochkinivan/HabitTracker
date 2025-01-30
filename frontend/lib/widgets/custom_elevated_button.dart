import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../app_colors.dart';

class CustomElevatedButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final bool isLoading;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isEnabled,
    this.isLoading = false,
  });

  @override
  _CustomElevatedButtonState createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.isEnabled ? widget.onPressed : null,
        style: ButtonStyle(
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          ),
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              return states.contains(MaterialState.disabled)
                  ? AppColors.gray04
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
                height: 1.2,
                color: states.contains(WidgetState.disabled)
                    ? AppColors.gray02
                    : AppColors.white,
              );
            },
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.isLoading)
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
            Text(widget.text),
            if (widget.isLoading) const SizedBox(width: 26),
          ],
        ),
      ),
    );
  }
}
