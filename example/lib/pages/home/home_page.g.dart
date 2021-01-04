// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page.dart';

// **************************************************************************
// PageCompilerGenerator
// **************************************************************************

class HomePageProvider {
  const HomePageProvider._();

  static const String name = '首页';
  static const String routeName = '/';

  static WidgetBuilder routeBuilder = (BuildContext context) {
    return HomePage();
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
