import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../app_colors.dart';

class ResendCodeButton extends StatefulWidget {
  final TextEditingController textEditingController;
  final VoidCallback? onPressed;

  const ResendCodeButton(
      {super.key, required this.textEditingController, this.onPressed});

  @override
  State<ResendCodeButton> createState() => _ResendCodeButtonState();
}

class _ResendCodeButtonState extends State<ResendCodeButton> {
  Timer? _timer;
  int _start = 5;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_start > 0) {
          _start--;
        } else {
          _canResend = true;
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _formattedTime {
    int minutes = _start ~/ 60;
    int seconds = _start % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void _sendCodeAgain() {
    if (_canResend) {
      widget.onPressed!();
      setState(() {
        _canResend = false;
        _start = 100;
      });
      _startTimer();
      widget.textEditingController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _canResend ? _sendCodeAgain : null,
      child: Text(
        _canResend
            ? 'Отправить код повторно'
            : 'Повторная отправка через $_formattedTime',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 14.sp,
            color: _canResend ? AppColors.black02 : AppColors.gray01),
      ),
    );
  }
}
