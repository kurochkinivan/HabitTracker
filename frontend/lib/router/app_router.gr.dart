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
class ColorChoiceRoute extends PageRouteInfo<ColorChoiceRouteArgs> {
  ColorChoiceRoute({
    Key? key,
    String? initialColor,
    List<PageRouteInfo>? children,
  }) : super(
          ColorChoiceRoute.name,
          args: ColorChoiceRouteArgs(
            key: key,
            initialColor: initialColor,
          ),
          initialChildren: children,
        );

  static const String name = 'ColorChoiceRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ColorChoiceRouteArgs>(
          orElse: () => const ColorChoiceRouteArgs());
      return ColorChoicePage(
        key: args.key,
        initialColor: args.initialColor,
      );
    },
  );
}

class ColorChoiceRouteArgs {
  const ColorChoiceRouteArgs({
    this.key,
    this.initialColor,
  });

  final Key? key;

  final String? initialColor;

  @override
  String toString() {
    return 'ColorChoiceRouteArgs{key: $key, initialColor: $initialColor}';
  }
}

/// generated route for
/// [HabitSettingsPage]
class HabitSettingsRoute extends PageRouteInfo<HabitSettingsRouteArgs> {
  HabitSettingsRoute({
    Key? key,
    String? selectedIcon,
    String? selectedColor,
    int? popularityIndex,
    String? name,
    String? description,
    String? category,
    bool? isActive,
    List<PageRouteInfo>? children,
  }) : super(
          HabitSettingsRoute.name,
          args: HabitSettingsRouteArgs(
            key: key,
            selectedIcon: selectedIcon,
            selectedColor: selectedColor,
            popularityIndex: popularityIndex,
            name: name,
            description: description,
            category: category,
            isActive: isActive,
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
        popularityIndex: args.popularityIndex,
        name: args.name,
        description: args.description,
        category: args.category,
        isActive: args.isActive,
      );
    },
  );
}

class HabitSettingsRouteArgs {
  const HabitSettingsRouteArgs({
    this.key,
    this.selectedIcon,
    this.selectedColor,
    this.popularityIndex,
    this.name,
    this.description,
    this.category,
    this.isActive,
  });

  final Key? key;

  final String? selectedIcon;

  final String? selectedColor;

  final int? popularityIndex;

  final String? name;

  final String? description;

  final String? category;

  final bool? isActive;

  @override
  String toString() {
    return 'HabitSettingsRouteArgs{key: $key, selectedIcon: $selectedIcon, selectedColor: $selectedColor, popularityIndex: $popularityIndex, name: $name, description: $description, category: $category, isActive: $isActive}';
  }
}

/// generated route for
/// [IconChoicePage]
class IconChoiceRoute extends PageRouteInfo<IconChoiceRouteArgs> {
  IconChoiceRoute({
    Key? key,
    String? initialIconName,
    List<PageRouteInfo>? children,
  }) : super(
          IconChoiceRoute.name,
          args: IconChoiceRouteArgs(
            key: key,
            initialIconName: initialIconName,
          ),
          initialChildren: children,
        );

  static const String name = 'IconChoiceRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<IconChoiceRouteArgs>(
          orElse: () => const IconChoiceRouteArgs());
      return IconChoicePage(
        key: args.key,
        initialIconName: args.initialIconName,
      );
    },
  );
}

class IconChoiceRouteArgs {
  const IconChoiceRouteArgs({
    this.key,
    this.initialIconName,
  });

  final Key? key;

  final String? initialIconName;

  @override
  String toString() {
    return 'IconChoiceRouteArgs{key: $key, initialIconName: $initialIconName}';
  }
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
