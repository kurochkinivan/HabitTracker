// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AddHabitPage]
class AddHabitRoute extends PageRouteInfo<void> {
  const AddHabitRoute({List<PageRouteInfo>? children})
      : super(
          AddHabitRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddHabitRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AddHabitPage();
    },
  );
}

/// generated route for
/// [ColorChoicePage]
class ColorChoiceRoute extends PageRouteInfo<void> {
  const ColorChoiceRoute({List<PageRouteInfo>? children})
      : super(
          ColorChoiceRoute.name,
          initialChildren: children,
        );

  static const String name = 'ColorChoiceRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ColorChoicePage();
    },
  );
}

/// generated route for
/// [HabitSettingsPage]
class HabitSettingsRoute extends PageRouteInfo<HabitSettingsRouteArgs> {
  HabitSettingsRoute({
    Key? key,
    String? selectedIcon,
    String? selectedColor,
    List<PageRouteInfo>? children,
  }) : super(
          HabitSettingsRoute.name,
          args: HabitSettingsRouteArgs(
            key: key,
            selectedIcon: selectedIcon,
            selectedColor: selectedColor,
          ),
          initialChildren: children,
        );

  static const String name = 'HabitSettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HabitSettingsRouteArgs>(
          orElse: () => const HabitSettingsRouteArgs());
      return HabitSettingsPage(
        key: args.key,
        selectedIcon: args.selectedIcon,
        selectedColor: args.selectedColor,
      );
    },
  );
}

class HabitSettingsRouteArgs {
  const HabitSettingsRouteArgs({
    this.key,
    this.selectedIcon,
    this.selectedColor,
  });

  final Key? key;

  final String? selectedIcon;

  final String? selectedColor;

  @override
  String toString() {
    return 'HabitSettingsRouteArgs{key: $key, selectedIcon: $selectedIcon, selectedColor: $selectedColor}';
  }
}

/// generated route for
/// [IconChoicePage]
class IconChoiceRoute extends PageRouteInfo<void> {
  const IconChoiceRoute({List<PageRouteInfo>? children})
      : super(
          IconChoiceRoute.name,
          initialChildren: children,
        );

  static const String name = 'IconChoiceRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const IconChoicePage();
    },
  );
}

/// generated route for
/// [NewPasswordPage]
class NewPasswordRoute extends PageRouteInfo<void> {
  const NewPasswordRoute({List<PageRouteInfo>? children})
      : super(
          NewPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewPasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NewPasswordPage();
    },
  );
}

/// generated route for
/// [PasswordRecoveryPage]
class PasswordRecoveryRoute extends PageRouteInfo<void> {
  const PasswordRecoveryRoute({List<PageRouteInfo>? children})
      : super(
          PasswordRecoveryRoute.name,
          initialChildren: children,
        );

  static const String name = 'PasswordRecoveryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PasswordRecoveryPage();
    },
  );
}

/// generated route for
/// [SignInPage]
class SignInRoute extends PageRouteInfo<void> {
  const SignInRoute({List<PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SignInPage();
    },
  );
}

/// generated route for
/// [SignUpPage]
class SignUpRoute extends PageRouteInfo<void> {
  const SignUpRoute({List<PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SignUpPage();
    },
  );
}

/// generated route for
/// [StartPage]
class StartRoute extends PageRouteInfo<void> {
  const StartRoute({List<PageRouteInfo>? children})
      : super(
          StartRoute.name,
          initialChildren: children,
        );

  static const String name = 'StartRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const StartPage();
    },
  );
}

/// generated route for
/// [VerifyEmailPage]
class VerifyEmailRoute extends PageRouteInfo<VerifyEmailRouteArgs> {
  VerifyEmailRoute({
    Key? key,
    required String email,
    List<PageRouteInfo>? children,
  }) : super(
          VerifyEmailRoute.name,
          args: VerifyEmailRouteArgs(
            key: key,
            email: email,
          ),
          initialChildren: children,
        );

  static const String name = 'VerifyEmailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VerifyEmailRouteArgs>();
      return VerifyEmailPage(
        key: args.key,
        email: args.email,
      );
    },
  );
}

class VerifyEmailRouteArgs {
  const VerifyEmailRouteArgs({
    this.key,
    required this.email,
  });

  final Key? key;

  final String email;

  @override
  String toString() {
    return 'VerifyEmailRouteArgs{key: $key, email: $email}';
  }
}

/// generated route for
/// [VerifyPasswordRecoveryPage]
class VerifyPasswordRecoveryRoute extends PageRouteInfo<void> {
  const VerifyPasswordRecoveryRoute({List<PageRouteInfo>? children})
      : super(
          VerifyPasswordRecoveryRoute.name,
          initialChildren: children,
        );

  static const String name = 'VerifyPasswordRecoveryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const VerifyPasswordRecoveryPage();
    },
  );
}
