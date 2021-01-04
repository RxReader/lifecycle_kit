// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// ManifestCompilerGenerator
// **************************************************************************

import 'package:flutter/widgets.dart';
import 'package:lifecycle_kit_example/pages/home/home_page.dart';
import 'package:lifecycle_kit_example/pages/not_found/not_found_page.dart';
import 'package:lifecycle_kit_example/pages/test/test_page.dart';

class AppManifest {
  const AppManifest._();

  static final Map<String, String> names = <String, String>{
    HomePageProvider.routeName: HomePageProvider.name,
    NotFoundPageProvider.routeName: NotFoundPageProvider.name,
    TestPageProvider.routeName: TestPageProvider.name,
  };

  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    HomePageProvider.routeName: HomePageProvider.routeBuilder,
    NotFoundPageProvider.routeName: NotFoundPageProvider.routeBuilder,
    TestPageProvider.routeName: TestPageProvider.routeBuilder,
  };
}
