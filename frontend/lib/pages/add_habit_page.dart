import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:habit_tracker/app_colors.dart';
import 'package:habit_tracker/widgets/custom_search_bar.dart';

import '../models/habits.dart';
import '../router/app_router.dart';
import '../widgets/category_section.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/habit_item.dart';

@RoutePage()
class AddHabitPage extends StatefulWidget {
  const AddHabitPage({super.key});

  @override
  AddHabitPageState createState() => AddHabitPageState();
}

class AddHabitPageState extends State<AddHabitPage> {
  final TextEditingController _searchContriller = TextEditingController();

  _searchHabits() {
    print(_searchContriller.text);
  }

  Map<String, List<Habit>> habitsByCategory = {
    'Fitness': [
      Habit(
          name: 'Running',
          color: Colors.blue,
          icon: 'assets/icons/running.png',
          popularityIndex: 0),
      Habit(
          name: 'Yoga',
          color: Colors.green,
          icon: 'assets/icons/yoga.png',
          popularityIndex: 3),
      Habit(
          name: 'Cycling',
          color: Colors.cyan,
          icon: 'assets/icons/cycling.png',
          popularityIndex: 5),
      Habit(
          name: 'Swimming',
          color: Colors.blueAccent,
          icon: 'assets/icons/swimming.png',
          popularityIndex: 4),
      Habit(
          name: 'Weightlifting',
          color: Colors.grey,
          icon: 'assets/icons/weightlifting.png',
          popularityIndex: 2),
      Habit(
          name: 'Walking',
          color: Colors.greenAccent,
          icon: 'assets/icons/walking.png',
          popularityIndex: 1),
    ],
    'Productivity': [
      Habit(
          name: 'Reading',
          color: Colors.purple,
          icon: 'assets/icons/reading.png',
          popularityIndex: 1),
      Habit(
          name: 'Meditation',
          color: Colors.orange,
          icon: 'assets/icons/meditation.png',
          popularityIndex: 2),
      Habit(
          name: 'Writing',
          color: Colors.deepOrange,
          icon: 'assets/icons/writing.png',
          popularityIndex: 3),
      Habit(
          name: 'Learning a language',
          color: Colors.yellow,
          icon: 'assets/icons/language.png',
          popularityIndex: 4),
      Habit(
          name: 'Time management',
          color: Colors.red,
          icon: 'assets/icons/time_management.png',
          popularityIndex: 5),
      Habit(
          name: 'Goal setting',
          color: Colors.blueGrey,
          icon: 'assets/icons/goal_setting.png',
          popularityIndex: 6),
    ],
    'Health': [
      Habit(
          name: 'Drinking water',
          color: Colors.lightBlue,
          icon: 'assets/icons/drinking_water.png',
          popularityIndex: 0),
      Habit(
          name: 'Eating healthy',
          color: Colors.green,
          icon: 'assets/icons/eating_healthy.png',
          popularityIndex: 1),
      Habit(
          name: 'Sleeping early',
          color: Colors.blueAccent,
          icon: 'assets/icons/sleeping_early.png',
          popularityIndex: 2),
      Habit(
          name: 'Taking vitamins',
          color: Colors.yellow,
          icon: 'assets/icons/taking_vitamins.png',
          popularityIndex: 3),
      Habit(
          name: 'Avoiding junk food',
          color: Colors.orange,
          icon: 'assets/icons/avoiding_junk_food.png',
          popularityIndex: 4),
    ],
    'Finance': [
      Habit(
          name: 'Saving money',
          color: Colors.green,
          icon: 'assets/icons/saving_money.png',
          popularityIndex: 0),
      Habit(
          name: 'Investing',
          color: Colors.blue,
          icon: 'assets/icons/investing.png',
          popularityIndex: 1),
      Habit(
          name: 'Budgeting',
          color: Colors.purple,
          icon: 'assets/icons/budgeting.png',
          popularityIndex: 2),
      Habit(
          name: 'Tracking expenses',
          color: Colors.teal,
          icon: 'assets/icons/tracking_expenses.png',
          popularityIndex: 3),
      Habit(
          name: 'Building credit',
          color: Colors.indigo,
          icon: 'assets/icons/building_credit.png',
          popularityIndex: 4),
    ],
    'Lifestyle': [
      Habit(
          name: 'Traveling',
          color: Colors.orange,
          icon: 'assets/icons/traveling.png',
          popularityIndex: 0),
      Habit(
          name: 'Photography',
          color: Colors.amber,
          icon: 'assets/icons/photography.png',
          popularityIndex: 1),
      Habit(
          name: 'Cooking',
          color: Colors.red,
          icon: 'assets/icons/cooking.png',
          popularityIndex: 2),
      Habit(
          name: 'Gardening',
          color: Colors.green,
          icon: 'assets/icons/gardening.png',
          popularityIndex: 3),
      Habit(
          name: 'Painting',
          color: Colors.blueGrey,
          icon: 'assets/icons/painting.png',
          popularityIndex: 4),
    ],
    'Social': [
      Habit(
          name: 'Socializing',
          color: Colors.pink,
          icon: 'assets/icons/socializing.png',
          popularityIndex: 0),
      Habit(
          name: 'Volunteering',
          color: Colors.deepPurple,
          icon: 'assets/icons/volunteering.png',
          popularityIndex: 1),
      Habit(
          name: 'Attending events',
          color: Colors.lightBlue,
          icon: 'assets/icons/attending_events.png',
          popularityIndex: 2),
      Habit(
          name: 'Networking',
          color: Colors.yellow,
          icon: 'assets/icons/networking.png',
          popularityIndex: 3),
      Habit(
          name: 'Hosting gatherings',
          color: Colors.greenAccent,
          icon: 'assets/icons/hosting_gatherings.png',
          popularityIndex: 4),
    ],
  };
  @override
  void initState() {
    sortedHabits = habitsByCategory.values.expand((list) => list).toList()
      ..sort((a, b) => a.popularityIndex.compareTo(b.popularityIndex));
    super.initState();
  }

  @override
  void dispose() {
    _searchContriller.dispose();
    super.dispose();
  }

  final List<String> _sortOptions = [
    'по популярности',
    'по категориям',
  ];
  String _selectedSort = 'по категориям';

  List<Habit> sortedHabits = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: 64.h, left: 22.w, right: 32.w, bottom: 20.h),
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
                      context.router.navigate(StartRoute());
                    },
                  ),
                  Spacer(),
                  Text(
                    'Добавить привычку',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(fontSize: 20.sp),
                  ),
                  Spacer(),
                  SizedBox(
                    width: 32.w,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSearchBar(
                      controller: _searchContriller, onChanged: _searchHabits),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Text(
                        'Сортировка: ',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: AppColors.black02),
                      ),
                      DropdownButton<String>(
                        value: _selectedSort,
                        icon: SizedBox.shrink(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedSort = newValue!;
                          });
                        },
                        items: _sortOptions
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: AppColors.purple,
                                  ),
                            ),
                          );
                        }).toList(),
                        borderRadius: BorderRadius.circular(8),
                        underline: SizedBox.shrink(),
                        dropdownColor: AppColors.white,
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  if (_selectedSort == 'по категориям')
                    Column(children: [
                      Divider(
                        color: AppColors.gray04,
                        thickness: 1.h,
                        height: 0,
                      ),
                      SizedBox(height: 16.h),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: habitsByCategory.length,
                        itemBuilder: (context, index) {
                          final entry =
                              habitsByCategory.entries.elementAt(index);
                          return CategorySection(
                              title: entry.key, habits: entry.value);
                        },
                      ),
                    ]),
                  if (_selectedSort == 'по популярности')
                    Column(children: [
                      SizedBox(height: 16.h),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: sortedHabits.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              HabitItem(
                                icon: sortedHabits[index].icon,
                                title: sortedHabits[index].name,
                                color: sortedHabits[index].color,
                              ),
                              if (index < sortedHabits.length - 1)
                                SizedBox(height: 10.h),
                            ],
                          );
                        },
                      ),
                    ]),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildActionButtons(context),
    );
  }
}

Widget _buildActionButtons(BuildContext context) {
  return Container(
    width: double.maxFinite,
    padding: EdgeInsets.symmetric(horizontal: 32.w),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 16.h),
        OutlinedButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/plus.svg",
                  height: 18.w,
                  width: 18.w,
                ),
                Text(
                  'Создать свою привычку',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontSize: 14.sp, color: AppColors.black01),
                )
              ],
            )),
        SizedBox(height: 12.h),
        CustomElevatedButton(
          onPressed: () {},
          text: 'Продолжить',
          isEnabled: true,
        ),
        SizedBox(height: 16.h),
      ],
    ),
  );
}
