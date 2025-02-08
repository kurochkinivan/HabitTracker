import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../app_colors.dart';

class CustomSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onChanged;

  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  bool _isActive = false;

  @override
  Widget build(BuildContext context) {
    _isActive = widget.controller.text.isNotEmpty;
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
        onChanged: (value) {
          setState(() {
            _isActive = value.isNotEmpty;
          });
          widget.onChanged();
        },
        decoration: InputDecoration(
          hintStyle: _getTextStyle(),
          hintText: 'Поиск...',
          contentPadding:
              EdgeInsets.symmetric(vertical: 16, horizontal: 16.w),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          suffixIcon: IconButton(
            icon: SvgPicture.asset(
              "assets/icons/search.svg",
              height: 24.w,
              width: 24.w,
              color: _getBorderColor(),
            ),
            onPressed: () {},
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
        ),
        style: _getTextStyle(),
        textAlignVertical: TextAlignVertical.center,
        cursorColor: AppColors.black01,
      ),
    );
  }

  Color _getFillColor() {
    if (_isActive) {
      return AppColors.gray03;
    }
    return AppColors.white;
  }

  Color _getBorderColor() {
    if (_isActive) {
      return AppColors.purple;
    }
    return AppColors.gray02;
  }

  TextStyle _getTextStyle() {
    return TextStyle(
      color: _isActive ? AppColors.black01 : AppColors.gray02,
      fontSize: 12.sp,
      fontFamily: 'Gilroy',
      fontWeight: FontWeight.w500,
      letterSpacing: -0.4,
    );
  }
}
