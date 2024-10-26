import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final ValueNotifier<bool> validateController;
  final VoidCallback onChanged;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.validateController,
    required this.onChanged,
    this.obscureText = false,
  });

  @override
  CustomTextFormFieldState createState() => CustomTextFormFieldState();
}

class CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isActive = false;
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;

    widget.validateController.addListener(_updateState);
  }

  void _updateState() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    widget.validateController.removeListener(_updateState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: _getFillColor(),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _getBorderColor(),
          width: 1.w,
        ),
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: _isObscured,
        obscuringCharacter: '●',
        onChanged: (value) {
          setState(() {
            _isActive = value.isNotEmpty;
          });
          widget.onChanged();
        },
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: _getTextStyle(),
          contentPadding:
              EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: SvgPicture.asset(
                    _isObscured
                        ? "assets/images/View_hide.svg"
                        : "assets/images/View.svg",
                    height: 20.w,
                    width: 20.w,
                    color: _getBorderColor(),
                  ),
                  onPressed: () => setState(() => _isObscured = !_isObscured),
                )
              : null,
        ),
        style: _getTextStyle(),
        textAlignVertical: TextAlignVertical.center,
      ),
    );
  }

  Color _getFillColor() {
    if (!widget.validateController.value) {
      return AppColors.red02;
    } else if (_isActive) {
      return AppColors.grey03;
    }
    return AppColors.white;
  }

  Color _getBorderColor() {
    if (!widget.validateController.value) {
      return AppColors.redError;
    } else if (_isActive) {
      return AppColors.purple;
    }
    return AppColors.grey02;
  }

  TextStyle _getTextStyle() {
    return TextStyle(
      color: !widget.validateController.value
          ? AppColors.redError
          : (_isActive ? AppColors.purple : AppColors.grey02),
      fontSize: 12.sp,
      fontFamily: 'Gilroy',
      fontWeight: FontWeight.w500,
      letterSpacing: -0.4,
    );
  }
}
