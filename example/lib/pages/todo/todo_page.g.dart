// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_page.dart';

// **************************************************************************
// PageCompilerGenerator
// **************************************************************************

class TodoPageController {
  String get name => TodoPageProvider.name;

  String get routeName => TodoPageProvider.routeName;

  WidgetBuilder get routeBuilder => TodoPageProvider.routeBuilder;

  String? get flavor => TodoPageProvider.flavor;

  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.isGetter) {
      switch (invocation.memberName) {
        case #name:
          return name;
        case #routeName:
          return routeName;
        case #routeBuilder:
          return routeBuilder;
        case #flavor:
          return flavor;
      }
    }
    return super.noSuchMethod(invocation);
  }
}

class TodoPageProvider {
  const TodoPageProvider._();

  static const String? flavor = null;

  static const String name = '待办';

  static const String routeName = '/todo';

  static final WidgetBuilder routeBuilder = (BuildContext context) {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    return TodoPage(
      key: arguments?['key'] as Key?,
    );
  };

  static Map<String, dynamic> routeArgument({
    Key? key,
  }) {
    return <String, dynamic>{
      'key': key,
    };
  }

  static Future<T?> pushByNamed<T extends Object?>(
    BuildContext context, {
    Key? key,
  }) {
    return Navigator.of(context).pushNamed(
      routeName,
      arguments: <String, dynamic>{
        'key': key,
      },
    );
  }
}
