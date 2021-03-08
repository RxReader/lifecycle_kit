import 'package:flutter/widgets.dart';
import 'package:lifecycle_kit/src/tracker.dart';

class LifecycleRouteObserver<R extends Route<dynamic>> extends RouteObserver<R> {
  LifecycleRouteObserver({
    required LifecycleTracker tracker,
  }) : _tracker = tracker;

  final LifecycleTracker _tracker;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (previousRoute != null) {
      _tracker.trackInactive(route: previousRoute);
    }
    _tracker.trackActive(route: route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _tracker.trackInactive(route: route);
    if (previousRoute != null) {
      _tracker.trackActive(route: previousRoute);
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    if (previousRoute?.isCurrent ?? false) {
      _tracker.trackInactive(route: route);
      _tracker.trackActive(route: previousRoute!);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute?.isCurrent ?? false) {
      if (oldRoute != null) {
        _tracker.trackInactive(route: oldRoute);
      }
      _tracker.trackActive(route: newRoute!);
    }
  }
}
