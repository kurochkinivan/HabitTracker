import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:habit_tracker/app_colors.dart';
import 'package:habit_tracker/widgets/custom_text_form_field.dart';
import '../models/repeat_type.dart';
import '../router/app_router.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/text_field_error_message.dart';

@RoutePage()
class HabitSettingsPage extends StatefulWidget {
  final String? selectedIcon;
  final String? selectedColor;
  final int? popularityIndex;
  final String? name;
  final String? description;
  final String? category;
  final bool? isActive;

  const HabitSettingsPage({
    super.key,
    this.selectedIcon,
    this.selectedColor,
    this.popularityIndex,
    this.name,
    this.description,
    this.category,
    this.isActive,
  });

  @override
  HabitSettingsPageState createState() => HabitSettingsPageState();
}

class HabitSettingsPageState extends State<HabitSettingsPage> {
  late String _selectedIcon;
  late String _selectedColor;

  final List<String> _selectedTimes = [];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  bool _isNameValid = true;
  bool _isDescriptionValid = true;
  bool _isCategoryValid = true;
  bool _isRepeatTypeValid = true;
  bool _isTimeValid = true;

  final String _pathToIcon = 'assets/icons/habit_icons/';

  RepeatType _repeatType = RepeatType.none;

  final Map<String, bool> _days = {
    'ПН': false,
    'ВТ': false,
    'СР': false,
    'ЧТ': false,
    'ПТ': false,
    'СБ': false,
    'ВС': false,
  };

  RepeatType get repeatType => _repeatType;
  bool get isValid => _repeatType != RepeatType.none;
  bool isDaySelected(String day) => _days[day] ?? false;
  @override
  void initState() {
    super.initState();
    _selectedIcon = widget.selectedIcon ?? 'woman_in_lotus_position.png';
    _selectedColor = widget.selectedColor ?? 'FFC6D1FE';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  int _compareTimes(String a, String b) {
    final TimeOfDay aTime = _parseTime(a);
    final TimeOfDay bTime = _parseTime(b);
    final int aMinutes = aTime.hour * 60 + aTime.minute;
    final int bMinutes = bTime.hour * 60 + bTime.minute;
    return aMinutes.compareTo(bMinutes);
  }

  TimeOfDay _parseTime(String time) {
    final parts = time.split(':');
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }

  @override
  void didUpdateWidget(HabitSettingsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIcon != _selectedIcon) {
      setState(() {
        _selectedIcon = widget.selectedIcon ?? 'woman_in_lotus_position.png';
      });
    }
    if (widget.selectedColor != _selectedColor) {
      setState(() {
        _selectedColor = widget.selectedColor ?? 'FFC6D1FE';
      });
    }
  }

  void _setRepeatType(RepeatType type) {
    setState(() {
      _repeatType = _repeatType == type ? RepeatType.none : type;

      if (_repeatType == RepeatType.daily) {
        _days.updateAll((_, __) => true);
      } else if (_repeatType == RepeatType.weekly) {
        _days.updateAll((_, __) => false);
      } else if (type == RepeatType.daily && _repeatType == RepeatType.none) {
        _days.updateAll((_, __) => false);
      }

      if (_repeatType != RepeatType.weekly && _days.values.every((v) => !v)) {
        _repeatType = RepeatType.none;
      }

      _isRepeatTypeValid = _repeatType != RepeatType.none;
    });
  }

  void _updateDayState(String day) {
    setState(() {
      _days[day] = !_days[day]!;

      if (_repeatType != RepeatType.custom) {
        _repeatType = RepeatType.custom;
      }

      if (_days.values.every((v) => v)) {
        _repeatType = RepeatType.daily;
      } else if (_repeatType == RepeatType.daily) {
        _repeatType = RepeatType.none;
        _days.updateAll((_, __) => false);
      }

      if (_days.values.every((v) => !v) && _repeatType != RepeatType.weekly) {
        _repeatType = RepeatType.none;
      }

      _isRepeatTypeValid = _repeatType != RepeatType.none;
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
                isValid: _isNameValid,
                onChanged: () {
                  setState(() {
                    _isNameValid = _nameController.text.isNotEmpty;
                  });
                },
              ),
              TextFieldErrorMessage(
                isValid: _isNameValid,
                message: "Поле не должно быть пустым",
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        context.router.navigate(
                            IconChoiceRoute(initialIconName: _selectedIcon));
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
                              child: Image.asset(_pathToIcon + _selectedIcon,
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
                      onTap: () => context.router.navigate(
                          ColorChoiceRoute(initialColor: _selectedColor)),
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
                                    Color(int.parse(_selectedColor, radix: 16)),
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
                  isValid: _isDescriptionValid,
                  onChanged: () {
                    setState(() {
                      _isDescriptionValid =
                          _descriptionController.text.isNotEmpty;
                    });
                  }),
              TextFieldErrorMessage(
                isValid: _isDescriptionValid,
                message: "Поле не должно быть пустым",
              ),
              SizedBox(height: 32.h),
              Text(
                "Категория",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SizedBox(height: 16.h),
              CustomTextFormField(
                  hintText: "Выберите категорию (необязательно)",
                  controller: _categoryController,
                  isValid: _isCategoryValid,
                  onChanged: () {
                    _isCategoryValid = true;
                  }),
              SizedBox(height: 32.h),
              Text(
                "Выберите дни повторения",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _days.keys
                    .map((day) => _buildDayButton(day, _days[day]!))
                    .toList(),
              ),
              SizedBox(height: 16.h),
              _buildRepeatOption(
                title: 'Каждый день',
                type: RepeatType.daily,
                currentType: _repeatType,
              ),
              SizedBox(height: 8.h),
              _buildRepeatOption(
                title: 'На протяжении недели',
                type: RepeatType.weekly,
                currentType: _repeatType,
              ),
              TextFieldErrorMessage(
                isValid: _isRepeatTypeValid,
                message: "Должен быть выбран тип повторения",
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
                          Icon(Icons.add, size: 12.w, color: AppColors.purple),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              TextFieldErrorMessage(
                isValid: _isTimeValid,
                message: "Должено быть добавлено время напоминания",
              ),
              SizedBox(height: 16.h),
              Wrap(
                spacing: 8.w,
                children: () {
                  final sortedTimes = List<String>.from(_selectedTimes)
                    ..sort(_compareTimes);
                  return sortedTimes
                      .map((time) => _buildTimeButton(time))
                      .toList();
                }(),
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
          _selectedTimes[_selectedTimes.indexOf(existingTime)] = formattedTime;
        } else if (!_selectedTimes.contains(formattedTime)) {
          _selectedTimes.add(formattedTime);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Это время уже добавлено.')),
          );
        }
        _isTimeValid = _selectedTimes.isNotEmpty;
      });
    }
  }

  Widget _buildTimeButton(String time) {
    return GestureDetector(
      onTap: () => _selectTime(context, existingTime: time),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColors.gray04,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              time,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.black02,
                    height: 1,
                  ),
            ),
            SizedBox(width: 8.w),
            GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedTimes.remove(time);
                    _isTimeValid = _selectedTimes.isNotEmpty;
                  });
                },
                child: SvgPicture.asset('assets/icons/trash-outline.svg',
                    width: 12.w, height: 12.w)),
          ],
        ),
      ),
    );
  }

  Widget _buildDayButton(String day, bool isSelected) {
    return GestureDetector(
      onTap: () => _updateDayState(day),
      child: Container(
        width: 40.w,
        height: 60.h,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.purple : AppColors.gray03,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(day,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: isSelected ? AppColors.white : AppColors.gray01,
                    )),
            SizedBox(height: 14.h),
            isSelected
                ? SvgPicture.asset('assets/icons/done_light.svg',
                    width: 20.w, height: 20.w)
                : SizedBox(width: 20.w, height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildRepeatOption({
    required String title,
    required RepeatType type,
    required RepeatType currentType,
  }) {
    final isSelected = currentType == type;

    return GestureDetector(
      onTap: () => _setRepeatType(type),
      child: Row(
        children: [
          Container(
            width: 16.w,
            height: 16.w,
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: isSelected ? AppColors.black02 : AppColors.gray02,
                width: 1.w,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: isSelected
                ? Container(
                    decoration: BoxDecoration(
                      color: AppColors.black02,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )
                : null,
          ),
          SizedBox(width: 8.w),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.black02,
                ),
          ),
        ],
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
              Map<String, bool> days = {
                'Mon': _days['ПН'] ?? false,
                'Tue': _days['ВТ'] ?? false,
                'Wed': _days['СР'] ?? false,
                'Thu': _days['ЧТ'] ?? false,
                'Fri': _days['ПТ'] ?? false,
                'Sat': _days['СБ'] ?? false,
                'Sun': _days['ВС'] ?? false,
              };
              print('Name: ${_nameController.text}');
              print('Description: ${_descriptionController.text}');
              print('Category: ${_categoryController.text}');
              print('Repeat Type: ${_repeatType.name}');
              print('Days: $days');
              print('Selected Times: $_selectedTimes');
              print('Selected Icon: $_selectedIcon');
              print('Selected Color: $_selectedColor');
            },
            text: 'Сохранить',
            isEnabled: _selectedTimes.isNotEmpty &&
                _repeatType != RepeatType.none &&
                _descriptionController.text.isNotEmpty &&
                _nameController.text.isNotEmpty,
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
