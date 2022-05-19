// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page.dart';

// **************************************************************************
// PageCompilerGenerator
// **************************************************************************

class HomePageController {
  String get name => HomePageProvider.name;

  String get routeName => HomePageProvider.routeName;

  WidgetBuilder get routeBuilder => HomePageProvider.routeBuilder;

  String? get flavor => HomePageProvider.flavor;

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

class HomePageProvider {
  const HomePageProvider._();

  static const String? flavor = null;

  static const String name = '首页';

  static const String routeName = '/';

  static final WidgetBuilder routeBuilder = (BuildContext context) {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    return HomePage(
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
