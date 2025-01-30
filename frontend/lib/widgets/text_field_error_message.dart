import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldErrorMessage extends StatelessWidget {
  final bool isValid;
  final String message;

  const TextFieldErrorMessage({
    super.key,
    required this.isValid,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    if (!isValid) {
      return Column(children: [
        SizedBox(height: 4.h),
        Text(
          message,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ]);
    }
    return SizedBox.shrink();
  }
}
