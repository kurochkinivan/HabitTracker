import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../app_colors.dart';
import '../router/app_router.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_elevated_button.dart';

@RoutePage()
class ColorChoicePage extends StatefulWidget {
  final String? initialColor;

  const ColorChoicePage({super.key, this.initialColor});

  @override
  State<ColorChoicePage> createState() => _ColorChoicePageState();
}

class _ColorChoicePageState extends State<ColorChoicePage> {
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
  void initState() {
    super.initState();
    if (widget.initialColor != null) {
      selectedIndex = habitColors.indexOf(widget.initialColor!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildActionButtons(context),
      appBar: CustomAppBar(
        onPressed: () => context.router.back(),
        label: "Выбор цвета",
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
