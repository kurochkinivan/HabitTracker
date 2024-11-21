import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:habit_tracker/app_colors.dart';
import 'package:habit_tracker/widgets/custom_text_form_field.dart';

import '../router/app_router.dart';
import '../widgets/custom_elevated_button.dart';

@RoutePage()
class HabitSettingsPage extends StatefulWidget {
  final String? selectedIcon;
  final String? selectedColor;
  const HabitSettingsPage({super.key, this.selectedIcon, this.selectedColor});

  @override
  HabitSettingsPageState createState() => HabitSettingsPageState();
}

class HabitSettingsPageState extends State<HabitSettingsPage> {
  late String selectedIcon;
  late String selectedColor;
  TimeOfDay? selectedTime;
  final List<String> selectedTimes = [];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  final ValueNotifier<bool> _isNameValid = ValueNotifier(true);
  final ValueNotifier<bool> _isDescriptionValid = ValueNotifier(true);
  final ValueNotifier<bool> _isCategoryValid = ValueNotifier(true);

  final ValueNotifier<bool> _isMon = ValueNotifier(false);
  final ValueNotifier<bool> _isTue = ValueNotifier(false);
  final ValueNotifier<bool> _isWed = ValueNotifier(true);
  final ValueNotifier<bool> _isThu = ValueNotifier(false);
  final ValueNotifier<bool> _isFri = ValueNotifier(false);
  final ValueNotifier<bool> _isSat = ValueNotifier(false);
  final ValueNotifier<bool> _isSun = ValueNotifier(false);

  late bool _isAllDaysChecked = false;

  @override
  void initState() {
    super.initState();
    selectedIcon = widget.selectedIcon ??
        'assets/icons/habit_icons/woman_in_lotus_position.png';

    selectedColor = widget.selectedColor ?? 'FFC6D1FE';
  }

  @override
  void didUpdateWidget(HabitSettingsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIcon != selectedIcon) {
      setState(() {
        selectedIcon = widget.selectedIcon ??
            'assets/icons/habit_icons/woman_in_lotus_position.png';
      });
    }
    if (widget.selectedColor != selectedColor) {
      setState(() {
        selectedColor = widget.selectedColor ?? 'FFC6D1FE';
      });
    }
  }

  void _toggleCheck() {
    setState(() {
      _isAllDaysChecked = !_isAllDaysChecked;
      if (_isAllDaysChecked) {
        _isMon.value = true;
        _isTue.value = true;
        _isWed.value = true;
        _isThu.value = true;
        _isFri.value = true;
        _isSat.value = true;
        _isSun.value = true;
      } else {
        _isMon.value = false;
        _isTue.value = false;
        _isWed.value = false;
        _isThu.value = false;
        _isFri.value = false;
        _isSat.value = false;
        _isSun.value = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildActionButtons(context),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.only(
            left: 8.w,
            right: 32.w,
          ),
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
                'Настройки привычки',
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(fontSize: 20.sp),
              ),
              Spacer(),
              SizedBox(
                width: 20.w,
              )
            ],
          ),
        ),
        toolbarHeight: 88.h,
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 32.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Что вы хотите делать?",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SizedBox(height: 16.h),
              CustomTextFormField(
                  hintText: "Название привычки",
                  controller: _nameController,
                  validateController: _isNameValid,
                  onChanged: () {
                    _isNameValid.value = _nameController.text.isNotEmpty;
                  }),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        context.router.navigate(IconChoiceRoute());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.h, horizontal: 10.h),
                        decoration: BoxDecoration(
                          color: AppColors.gray04,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 32.w,
                              height: 32.w,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE4E2EC),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Image.asset(selectedIcon,
                                  width: 20.w, height: 20.w),
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              'Иконка',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: AppColors.black02,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => context.router.navigate(ColorChoiceRoute()),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.h, horizontal: 10.w),
                        decoration: BoxDecoration(
                          color: AppColors.gray04,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 32.w,
                              height: 32.w,
                              decoration: BoxDecoration(
                                color:
                                    Color(int.parse(selectedColor, radix: 16)),
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              'Цвет',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: AppColors.black02,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              Text(
                "Опишите свою привычку",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SizedBox(height: 16.h),
              CustomTextFormField(
                  hintText: "Введите описание",
                  controller: _descriptionController,
                  validateController: _isDescriptionValid,
                  onChanged: () {
                    _isDescriptionValid.value =
                        _descriptionController.text.isNotEmpty;
                  }),
              SizedBox(height: 32.h),
              Text(
                "Категория",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SizedBox(height: 16.h),
              CustomTextFormField(
                  hintText: "Выберите категорию (необязательно)",
                  controller: _categoryController,
                  validateController: _isCategoryValid,
                  onChanged: () {
                    _isCategoryValid.value =
                        _categoryController.text.isNotEmpty;
                  }),
              SizedBox(height: 32.h),
              Text(
                "Выберите дни выполнения",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDayButton('ПН', _isMon),
                  _buildDayButton('ВТ', _isTue),
                  _buildDayButton('СР', _isWed),
                  _buildDayButton('ЧТ', _isThu),
                  _buildDayButton('ПТ', _isFri),
                  _buildDayButton('СБ', _isSat),
                  _buildDayButton('ВС', _isSun),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  GestureDetector(
                    onTap: _toggleCheck,
                    child: Container(
                      width: 16.w,
                      height: 16.w,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.gray02),
                        borderRadius: BorderRadius.circular(100),
                        color: _isAllDaysChecked
                            ? AppColors.purple
                            : Colors.transparent,
                      ),
                      child: _isAllDaysChecked
                          ? Icon(Icons.check,
                              size: 12.w, color: AppColors.white)
                          : null,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text('Каждый день',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: AppColors.black02)),
                ],
              ),
              SizedBox(height: 32.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Напоминания',
                      style: Theme.of(context).textTheme.displaySmall),
                  GestureDetector(
                    onTap: () => _selectTime(context),
                    child: Container(
                      width: 24.w,
                      height: 24.w,
                      decoration: BoxDecoration(
                        color: AppColors.gray04,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, size: 12.w, color: AppColors.gray01),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Wrap(
                children: selectedTimes
                    .map((time) => _buildTimeButton(time))
                    .toList(),
              ),
              SizedBox(height: 16.h)
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context, {String? existingTime}) async {
    final initialTime = existingTime != null
        ? TimeOfDay(
            hour: int.parse(existingTime.split(':')[0]),
            minute: int.parse(existingTime.split(':')[1]),
          )
        : TimeOfDay.now();

    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.purple,
              onSurface: AppColors.black01,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.purple,
              ),
            ),
          ),
          child: child!,
        );
      },
      initialEntryMode: TimePickerEntryMode.input,
    );

    if (time != null) {
      final formattedTime =
          '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';

      setState(() {
        if (existingTime != null) {
          selectedTimes[selectedTimes.indexOf(existingTime)] = formattedTime;
        } else if (!selectedTimes.contains(formattedTime)) {
          selectedTimes.add(formattedTime);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Это время уже добавлено.')),
          );
        }
      });
    }
  }

  Widget _buildTimeButton(String time) {
    return GestureDetector(
      onTap: () => _selectTime(context, existingTime: time),
      child: Container(
        margin: EdgeInsets.only(right: 8.w, bottom: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColors.gray04,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              time,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.black02,
                  ),
            ),
            SizedBox(width: 8.w),
            GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTimes.remove(time);
                  });
                },
                child: SvgPicture.asset('assets/icons/trash-outline.svg',
                    width: 12.w, height: 12.w)),
          ],
        ),
      ),
    );
  }

  Widget _buildDayButton(String day, ValueNotifier<bool> isSelected) {
    return GestureDetector(
        onTap: () {
          setState(() {
            isSelected.value = !isSelected.value;
            if(isSelected.value == false) {
              _isAllDaysChecked = false;
            }
          });
        },
        child: Container(
          width: 40.w,
          height: 65.h,
          decoration: BoxDecoration(
            color: isSelected.value ? AppColors.purple : AppColors.gray03,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(day,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: isSelected.value
                            ? AppColors.white
                            : AppColors.gray01,
                      )),
              if (isSelected.value) SizedBox(height: 14.h),
              if (isSelected.value)
                SvgPicture.asset('assets/icons/done_light.svg',
                    width: 20.w, height: 20.w),
              if (!isSelected.value) SizedBox(height: 14.h),
              if (!isSelected.value) SizedBox(width: 20.w, height: 20.h),
            ],
          ),
        ));
  }

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomElevatedButton(
            onPressed: () {},
            text: 'Сохранить',
            isEnabled: true,
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
