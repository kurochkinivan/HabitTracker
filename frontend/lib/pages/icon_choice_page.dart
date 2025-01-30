import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../app_colors.dart';
import '../router/app_router.dart';
import '../widgets/custom_elevated_button.dart';

@RoutePage()
class IconChoicePage extends StatefulWidget {
  final String? initialIconName;

  const IconChoicePage({super.key, this.initialIconName});

  @override
  IconChoicePageState createState() => IconChoicePageState();
}

class IconChoicePageState extends State<IconChoicePage> {
  final List<String> imageUrls = [
    'books.png',
    'books.png',
    'books.png',
    'books.png',
    'woman_in_lotus_position.png',
    'running.png',
    'books.png',
    'books.png',
  ];

  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    if (widget.initialIconName != null) {
      selectedIndex = imageUrls.indexOf(widget.initialIconName!);
    }
  }

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
          itemCount: imageUrls.length,
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
                  color: isSelected
                      ? const Color(0xFFDDC6F7)
                      : const Color(0xFFF2F1F9),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Image.asset(
                    "assets/icons/habit_icons/${imageUrls[index]}",
                    width: 33,
                    height: 33,
                    semanticLabel: 'Icon option ${index + 1}',
                  ),
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
                    selectedIcon: imageUrls[selectedIndex!]));
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
