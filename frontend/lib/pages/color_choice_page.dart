import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../app_colors.dart';
import '../router/app_router.dart';
import '../widgets/custom_elevated_button.dart';

@RoutePage()
class ColorChoicePage extends StatefulWidget {
  const ColorChoicePage({super.key});

  @override
  ColorChoicePageState createState() => ColorChoicePageState();
}

class ColorChoicePageState extends State<ColorChoicePage> {
  final List<String> habitColors = [
    'FFABEBB0',
    'FFFCD29F',
    'FFC6D1FE',
    'FFFCCAEB',
    'FFFCCAEB',
    'FFFCCAEB',
    'FFFCCAEB',
  ];

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildActionButtons(context),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.only(left: 8.w, right: 32.w),
          child: Row(
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/arrow_left.svg",
                  height: 32.w,
                  width: 32.w,
                  fit: BoxFit.contain,
                ),
                onPressed: () {
                  context.router.back();
                },
              ),
              Spacer(),
              Text(
                'Выбор иконки',
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(fontSize: 20.sp),
              ),
              Spacer(),
              SizedBox(width: 20.w)
            ],
          ),
        ),
        toolbarHeight: 88.h,
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: habitColors.length,
          itemBuilder: (context, index) {
            bool isSelected = selectedIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(int.parse(habitColors[index], radix: 16)),
                  borderRadius: BorderRadius.circular(6),
                  border: isSelected
                      ? Border.all(
                          color: AppColors.purple,
                          width: 1,
                        )
                      : null,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomElevatedButton(
            onPressed: () {
              if (selectedIndex != null) {
                context.router.navigate(HabitSettingsRoute(
                    selectedColor: habitColors[selectedIndex!]));
              }
            },
            text: 'Выбрать',
            isEnabled: selectedIndex != null,
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
