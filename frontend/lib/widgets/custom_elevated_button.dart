import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../ui_scaling.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isEnabled;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    final scaling = Scaling.of(context);
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ButtonStyle(
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(vertical: 16, horizontal: 38),
        ),
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.grey03;
            }
            return AppColors.black01;
          },
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        textStyle: WidgetStateProperty.resolveWith<TextStyle>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.disabled)) {
                  return TextStyle(
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w600,
                    fontSize: scaling.scaleWidth(14),
                    letterSpacing: -0.4,
                    height: 1.3,
                    color: AppColors.grey01,
                  );
                }
                else {
                  return TextStyle(
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w600,
                    fontSize: scaling.scaleWidth(14),
                    letterSpacing: -0.4,
                    height: 1.3,
                    color: AppColors.white,
                  );
                }
              },
        ),
      ),
      child: Center(
        child: Text(text),
      ),
    );
  }
}
