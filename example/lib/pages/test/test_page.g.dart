// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_page.dart';

// **************************************************************************
// PageCompilerGenerator
// **************************************************************************

class TestPageProvider {
  const TestPageProvider._();

  static const String name = '测试';
  static const String routeName = '/test';

  static WidgetBuilder routeBuilder = (BuildContext context) {
    return TestPage();
  };

  static Future<T> pushByNamed<T extends Object>(BuildContext context) {
    return Navigator.of(context).pushNamed(routeName);
  }
}
