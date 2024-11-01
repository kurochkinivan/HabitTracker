import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldErrorMessage extends StatelessWidget {
  final ValueNotifier<bool> validator;
  final String message;

  const TextFieldErrorMessage({
    super.key,
    required this.validator,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: validator,
      builder: (context, isValid, child) {
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
      },
    );
  }
}
