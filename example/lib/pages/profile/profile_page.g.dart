// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_page.dart';

// **************************************************************************
// PageCompilerGenerator
// **************************************************************************

class ProfilePageProvider {
  const ProfilePageProvider._();

  static const String name = '我的';
  static const String routeName = '/profile';

  static WidgetBuilder routeBuilder = (BuildContext context) {
    return ProfilePage();
  };

  static Map<String, dynamic> routeArgument() {
    Map<String, dynamic> arguments = <String, dynamic>{};
    return arguments;
  }

  static Future<T> pushByNamed<T extends Object>(
    BuildContext context,
  ) {
    Map<String, dynamic> arguments = <String, dynamic>{};
    return Navigator.of(context).pushNamed(
      routeName,
      arguments: arguments,
    );
  }
}
