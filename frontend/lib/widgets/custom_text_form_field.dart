import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final bool isValid;
  final VoidCallback onChanged;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.isValid,
    required this.onChanged,
    this.obscureText = false,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isActive = false;
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
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
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16.w),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: SvgPicture.asset(
                    _isObscured
                        ? "assets/icons/view.svg"
                        : "assets/icons/view_hide.svg",
                    height: 24.w,
                    width: 24.w,
                    color: _getBorderColor(),
                  ),
                  onPressed: () => setState(() => _isObscured = !_isObscured),
                )
              : null,
        ),
        style: _getTextStyle(),
        cursorColor: widget.isValid ? AppColors.black01 : AppColors.redError,
      ),
    );
  }

  Color _getFillColor() {
    if (!widget.isValid) {
      return AppColors.red02;
    } else if (_isActive) {
      return AppColors.gray03;
    }
    return AppColors.white;
  }

  Color _getBorderColor() {
    if (!widget.isValid) {
      return AppColors.redError;
    } else if (_isActive) {
      return AppColors.purple;
    }
    return AppColors.gray02;
  }

  TextStyle _getTextStyle() {
    return TextStyle(
      color: !widget.isValid
          ? AppColors.redError
          : (_isActive ? AppColors.black01 : AppColors.gray02),
      fontSize: 12.sp,
      fontFamily: 'Gilroy',
      fontWeight: FontWeight.w500,
      letterSpacing: -0.4,
    );
  }
}
