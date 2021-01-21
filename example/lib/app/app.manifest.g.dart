// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// ManifestCompilerGenerator
// **************************************************************************

import 'package:flutter/widgets.dart';
import 'package:lifecycle_kit_example/pages/home/home_page.dart';
import 'package:lifecycle_kit_example/pages/not_found/not_found_page.dart';
import 'package:lifecycle_kit_example/pages/profile/profile_page.dart';
import 'package:lifecycle_kit_example/pages/test/test_page.dart';
import 'package:lifecycle_kit_example/pages/todo/todo_page.dart';

class AppManifest {
  const AppManifest._();

  static final Map<String, String> names = <String, String>{
    HomePageProvider.routeName: HomePageProvider.name,
    NotFoundPageProvider.routeName: NotFoundPageProvider.name,
    ProfilePageProvider.routeName: ProfilePageProvider.name,
    TestPageProvider.routeName: TestPageProvider.name,
    TodoPageProvider.routeName: TodoPageProvider.name,
  };

  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    HomePageProvider.routeName: HomePageProvider.routeBuilder,
    NotFoundPageProvider.routeName: NotFoundPageProvider.routeBuilder,
    ProfilePageProvider.routeName: ProfilePageProvider.routeBuilder,
    TestPageProvider.routeName: TestPageProvider.routeBuilder,
    TodoPageProvider.routeName: TodoPageProvider.routeBuilder,
  };
}
