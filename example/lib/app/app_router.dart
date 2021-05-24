import 'package:flutter/material.dart';
import 'package:lifecycle_kit/lifecycle_kit.dart';
import 'package:lifecycle_kit_example/pages/home/home_page.dart';
import 'package:lifecycle_kit_example/pages/not_found/not_found_page.dart';
import 'package:lifecycle_kit_example/pages/profile/profile_page.dart';
import 'package:lifecycle_kit_example/pages/test/test_page.dart';
import 'package:lifecycle_kit_example/pages/todo/todo_page.dart';
import 'package:router_api/router_api.dart' as ra;

mixin Manifest on ra.Router {
  @override
  @protected
  void registerBuiltIn() {
    useController(controller: HomePageProvider.controller);
    useController(controller: NotFoundPageProvider.controller);
    useController(controller: ProfilePageProvider.controller);
    useController(controller: TestPageProvider.controller);
    useController(controller: TodoPageProvider.controller);
  }
}

class AppRouter extends ra.Router with Manifest {
  AppRouter._() : super();

  static AppRouter get instance => _instance ??= AppRouter._();
  static AppRouter? _instance;

  Future<dynamic?> pushNamed(BuildContext context, String routeName, {Object? arguments}) {
    final List<ra.Interceptor> activeInterceptors = <ra.Interceptor>[
      ...interceptors,
      if (routeInterceptors.containsKey(routeName)) routeInterceptors[routeName]!,
    ];
    final List<ra.Next> nexts = <ra.Next>[
          () => Navigator.of(context).pushNamed(routeName, arguments: arguments),
    ];
    for (final ra.Interceptor interceptor in activeInterceptors.reversed) {
      final ra.Next next = nexts.last;
      nexts.add(() => interceptor.call(context, routeName, arguments: arguments, next: next));
    }
    return nexts.last.call();
  }

  Future<dynamic?> pushReplacementNamed(BuildContext context, String routeName, {Object? result, Object? arguments}) {
    final List<ra.Interceptor> activeInterceptors = <ra.Interceptor>[
      ...interceptors,
      if (routeInterceptors.containsKey(routeName)) routeInterceptors[routeName]!,
    ];
    final List<ra.Next> nexts = <ra.Next>[
          () => Navigator.of(context).pushReplacementNamed(routeName, result: result, arguments: arguments),
    ];
    for (final ra.Interceptor interceptor in activeInterceptors.reversed) {
      final ra.Next next = nexts.last;
      nexts.add(() => interceptor.call(context, routeName, arguments: arguments, next: next));
    }
    return nexts.last.call();
  }
}

class RouteTracker implements LifecycleTracker {
  const RouteTracker({
    this.onActive,
    this.onInactive,
  });

  final void Function(Route<dynamic> route)? onActive;
  final void Function(Route<dynamic> route)? onInactive;

  @override
  void trackActive({required Route<dynamic> route}) {
    onActive?.call(route);
  }

  @override
  void trackInactive({required Route<dynamic> route}) {
    onInactive?.call(route);
  }
}
