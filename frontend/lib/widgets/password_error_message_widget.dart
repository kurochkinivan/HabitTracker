import 'package:flutter/material.dart';
import '../ui_scaling.dart';

class PasswordErrorMessage extends StatelessWidget {
  final ValueNotifier<bool> validator;
  final String message;

  const PasswordErrorMessage({
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
            SizedBox(height: Scaling.of(context).scaleHeight(4)),
            Text(
              message,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontSize: Scaling.of(context).scaleWidth(12),
                  ),
            ),
          ]);
        }
        return SizedBox.shrink();
      },
    );
  }
}
