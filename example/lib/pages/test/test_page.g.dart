// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_page.dart';

// **************************************************************************
// PageCompilerGenerator
// **************************************************************************

class TestPageController {
  String get name => TestPageProvider.name;

  String get routeName => TestPageProvider.routeName;

  WidgetBuilder get routeBuilder => TestPageProvider.routeBuilder;

  String? get flavor => TestPageProvider.flavor;

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

class TestPageProvider {
  const TestPageProvider._();

  static const String? flavor = null;

  static const String name = '测试';

  static const String routeName = '/test';

  static final WidgetBuilder routeBuilder = (BuildContext context) {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    return TestPage(
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
