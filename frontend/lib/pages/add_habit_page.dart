import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:habit_tracker/app_colors.dart';
import 'package:habit_tracker/widgets/custom_search_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/habits/habits_bloc.dart';
import '../bloc/habits/habits_event.dart';
import '../bloc/habits/habits_state.dart';
import '../models/habit_action_type.dart';
import '../models/habits.dart';
import '../router/app_router.dart';
import '../router/navigation_service.dart';
import '../services/api_client.dart';
import '../widgets/category_section.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/habit_item.dart';

@RoutePage()
class AddHabitPage extends StatelessWidget {
  const AddHabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    final apiClient = RepositoryProvider.of<ApiClient>(context);

    return BlocProvider(
      create: (_) => HabitsBloc(apiClient: apiClient),
      child: const AddHabitPageContent(),
    );
  }
}

class AddHabitPageContent extends StatefulWidget {
  const AddHabitPageContent({super.key});

  @override
  State<AddHabitPageContent> createState() => _AddHabitPageContentState();
}

class _AddHabitPageContentState extends State<AddHabitPageContent> {
  final TextEditingController _searchController = TextEditingController();
  String _serverErrorText = '';
  bool _isRequestCorrect = true;

  @override
  void initState() {
    super.initState();
    _fetchUserHabits();
  }

  Future<void> _fetchUserHabits() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final userId = sharedPrefs.getString('user_id'); // Replace with actual user ID
    context.read<HabitsBloc>().add(HabitsEvent.getUserHabits(userId: userId!));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          onPressed: () => context.router.navigate(StartRoute()),
          label: "Добавить привычку"),
      body: BlocConsumer<HabitsBloc, HabitsState>(
        listenWhen: (previous, current) {
          return current.when(
            initial: () => false,
            loading: (action) => action == HabitActionType.getUserHabits,
            success: (action, message, days, categories, habits) =>
            action == HabitActionType.getUserHabits,
            failure: (action, errorMessage) =>
            action == HabitActionType.getUserHabits,
          );
        },
        buildWhen: (previous, current) {
          return current.when(
            initial: () => true,
            loading: (action) => action == HabitActionType.getUserHabits,
            success: (action, message, days, categories, habits) =>
            action == HabitActionType.getUserHabits,
            failure: (action, errorMessage) =>
            action == HabitActionType.getUserHabits,
          );
        },
        listener: (context, state) {
          state.whenOrNull(
            loading: (action) {},
            success: (action, message, days, categories, habits) {
              if (!(ModalRoute.of(context)?.isCurrent ?? false)) {
                return;
              }
              // Handle success state
            },
            failure: (action, errorMessage) {
              setState(() {
                _serverErrorText = errorMessage;
                _isRequestCorrect = false;
              });
            },
          );
        },
        builder: (context, state) {
          bool isLoading = false;
          state.maybeWhen(
            loading: (action) {
              isLoading = true;
            },
            orElse: () {},
          );
          return Column(
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
                    // Add other UI elements here
                  ],
                ),
              ),
              // Add other UI elements here
              if (isLoading)
                Center(child: CircularProgressIndicator())
              else
              // Display habits or error message
                _isRequestCorrect
                    ? Text('Habits loaded successfully')
                    : Text(_serverErrorText),
            ],
          );
        },
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
              NavigationService().navigate(context, HabitSettingsRoute());
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
