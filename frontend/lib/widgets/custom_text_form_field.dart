import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../ui_scaling.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final bool Function(String)? validate;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.validate,
  });

  @override
  CustomTextFormFieldState createState() => CustomTextFormFieldState();
}

class CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isActive = false;
  bool _hasError = false;
  bool _isObscured = true;
  late Scaling scaling;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    scaling = Scaling.of(context);

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: _getFillColor(),
        borderRadius: BorderRadius.circular(scaling.scaleWidth(8)),
        border: Border.all(
          color: _getBorderColor(),
          width: scaling.scaleWidth(1),
        ),
      ),
      child: TextFormField(
        controller: _controller,
        obscureText: _isObscured,
        obscuringCharacter: '●',
        onChanged: (value) {
          setState(() {
            _isActive = value.isNotEmpty;
            if (widget.validate != null) {
              _hasError = !(widget.validate!(value));
            }
          });
        },
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: _getTextStyle(),
          contentPadding: EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 16,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          suffixIcon: widget.obscureText
              ? AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: GestureDetector(
                    key: ValueKey(_isObscured),
                    onTap: () {
                      setState(() {
                        _isObscured = !_isObscured;
                      });
                    },
                    child: SvgPicture.asset(
                      _isObscured
                          ? "assets/images/View_hide.svg"
                          : "assets/images/View.svg",
                      height: scaling.scaleWidth(20),
                      width: scaling.scaleWidth(20),
                      color: _getBorderColor(),
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              : null,
        ),
        style: _getTextStyle(),
        textAlignVertical: TextAlignVertical.center,
      ),
    );
  }

  Color _getFillColor() {
    if (_hasError) {
      return Color(0xFFFFE5E3);
    } else if (_isActive) {
      return Color(0xFFEAE8F3);
    } else {
      return Color(0xFFFCFCFF);
    }
  }

  Color _getBorderColor() {
    if (_hasError) {
      return Color(0xFFEA4335);
    } else if (_isActive) {
      return Color(0xFF9EA0B8);
    } else {
      return Color(0xFFC6C8DA);
    }
  }

  TextStyle _getTextStyle() {
    return TextStyle(
      color: _hasError
          ? Color(0xFFEA4335)
          : (_isActive ? Color(0xFF3C3D42) : Color(0xFFC6C8DA)),
      fontSize: scaling.scaleWidth(12),
      fontFamily: 'Gilroy',
      fontWeight: FontWeight.w500,
      letterSpacing: -0.4,
    );
  }
}
