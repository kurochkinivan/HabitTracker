import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuzzy/fuzzy.dart';
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
  final TextEditingController _searchController = TextEditingController();
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

  final List<String> _sortOptions = [
    'по популярности',
    'по категориям',
    'по поиску',
  ];
  String _selectedSort = 'по категориям';

  late List<Habit> sortedHabits;
  List<Habit> filteredHabits = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    sortedHabits = habitsByCategory.values.expand((list) => list).toList()
      ..sort((a, b) => a.popularityIndex.compareTo(b.popularityIndex));
    filteredHabits = List.from(sortedHabits);
    _searchController.addListener(_filterHabits);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterHabits() {
    final query = _searchController.text.toLowerCase();

    if (query.isEmpty) {
      for (var i = filteredHabits.length - 1; i >= 0; i--) {
        final removedHabit = filteredHabits.removeAt(i);
        _listKey.currentState?.removeItem(
          i,
          (context, animation) => _buildHabitItem(removedHabit, animation),
        );
      }
    } else {
      final fuse = Fuzzy<Habit>(
        sortedHabits,
        options: FuzzyOptions(
          keys: [
            WeightedKey<Habit>(
              name: 'name',
              getter: (habit) => habit.name,
              weight: 1.0,
            ),
          ],
          threshold: 0.1,
        ),
      );

      final results = fuse.search(query);
      final newFilteredHabits = results.map((result) => result.item).toList();

      for (var i = filteredHabits.length - 1; i >= 0; i--) {
        if (!newFilteredHabits.contains(filteredHabits[i])) {
          final removedHabit = filteredHabits.removeAt(i);
          _listKey.currentState?.removeItem(
            i,
            (context, animation) => _buildHabitItem(removedHabit, animation),
          );
        }
      }

      for (var i = 0; i < newFilteredHabits.length; i++) {
        if (!filteredHabits.contains(newFilteredHabits[i])) {
          filteredHabits.insert(i, newFilteredHabits[i]);
          _listKey.currentState?.insertItem(i);
        }
      }
    }
  }

  Widget _buildHabitItem(Habit? habit, Animation<double> animation) {
    if (habit == null) {
      return SizedBox.shrink();
    }

    return SlideTransition(
      position: animation.drive(
        Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
            .chain(CurveTween(curve: Curves.easeOut)),
      ),
      child: Column(
        children: [
          HabitItem(
            icon: habit.icon,
            title: habit.name,
            color: habit.color,
            query: _searchController.text.toLowerCase(),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_searchController.text.isNotEmpty && _selectedSort != 'по поиску') {
      _selectedSort = 'по поиску';
    }
    return Scaffold(
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
                // context.router.back();
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
                width: 20.w,
              )
            ],
          ),
        ),
        toolbarHeight: 88.h,
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSearchBar(
                    controller: _searchController,
                    onChanged: () {
                      setState(() {});
                    }),
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
                          if (newValue != 'по поиску') {
                            _selectedSort = newValue!;
                            _searchController.clear();
                          }
                        });
                      },
                      items: _sortOptions
                          .where((option) =>
                              option != 'по поиску' ||
                              _selectedSort == 'по поиску')
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
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
              ],
            ),
          ),
          SizedBox(height: 16.h),
          if (_searchController.text.isNotEmpty)
            Expanded(
              child: filteredHabits.isEmpty
                  ? Center(
                      child: Text('Ничего не найдено',
                          style: TextStyle(
                              fontSize: 20.sp, color: AppColors.gray01)),
                    )
                  : AnimatedList(
                      key: _listKey,
                      initialItemCount: filteredHabits.length,
                      padding: EdgeInsets.symmetric(horizontal: 32.w),
                      itemBuilder: (context, index, animation) {
                        final habit = filteredHabits[index];
                        return _buildHabitItem(habit, animation);
                      },
                    ),
            ),
          if (_selectedSort == 'по категориям' &&
              _searchController.text.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(children: [
                Divider(
                  color: AppColors.gray04,
                  thickness: 1.h,
                  height: 0,
                ),
                SizedBox(height: 16.h),
              ]),
            ),
          if (_selectedSort == 'по категориям' &&
              _searchController.text.isEmpty)
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                itemCount: habitsByCategory.length,
                itemBuilder: (context, index) {
                  final entry = habitsByCategory.entries.elementAt(index);
                  return CategorySection(title: entry.key, habits: entry.value);
                },
              ),
            ),
          if (_selectedSort == 'по популярности' &&
              _searchController.text.isEmpty)
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
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
            ),
          SizedBox(height: 16),
        ],
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
        OutlinedButton(
            onPressed: () {
              context.router.navigate(HabitSettingsRoute());
            },
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
        SizedBox(height: 24.h),
      ],
    ),
  );
}
