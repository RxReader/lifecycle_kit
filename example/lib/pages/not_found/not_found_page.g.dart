// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'not_found_page.dart';

// **************************************************************************
// PageCompilerGenerator
// **************************************************************************

class NotFoundPageController {
  String get name => NotFoundPageProvider.name;

  String get routeName => NotFoundPageProvider.routeName;

  WidgetBuilder get routeBuilder => NotFoundPageProvider.routeBuilder;

  String? get flavor => NotFoundPageProvider.flavor;

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

class NotFoundPageProvider {
  const NotFoundPageProvider._();

  static const String? flavor = null;

  static const String name = '404';

  static const String routeName = '/not_found';

  static final WidgetBuilder routeBuilder = (BuildContext context) {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    return NotFoundPage(
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
