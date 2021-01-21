// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_page.dart';

// **************************************************************************
// PageCompilerGenerator
// **************************************************************************

class TodoPageProvider {
  const TodoPageProvider._();

  static const String name = '待办';
  static const String routeName = '/todo';

  static WidgetBuilder routeBuilder = (BuildContext context) {
    return TodoPage();
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
