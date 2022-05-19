// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_page.dart';

// **************************************************************************
// PageCompilerGenerator
// **************************************************************************

class ProfilePageController {
  String get name => ProfilePageProvider.name;

  String get routeName => ProfilePageProvider.routeName;

  WidgetBuilder get routeBuilder => ProfilePageProvider.routeBuilder;

  String? get flavor => ProfilePageProvider.flavor;

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

class ProfilePageProvider {
  const ProfilePageProvider._();

  static const String? flavor = null;

  static const String name = '我的';

  static const String routeName = '/profile';

  static final WidgetBuilder routeBuilder = (BuildContext context) {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    return ProfilePage(
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
