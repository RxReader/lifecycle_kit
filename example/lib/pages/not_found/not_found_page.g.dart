// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'not_found_page.dart';

// **************************************************************************
// PageCompilerGenerator
// **************************************************************************

class NotFoundPageProvider {
  const NotFoundPageProvider._();

  static const String name = '404';
  static const String routeName = '/not_found';

  static WidgetBuilder routeBuilder = (BuildContext context) {
    return NotFoundPage();
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
