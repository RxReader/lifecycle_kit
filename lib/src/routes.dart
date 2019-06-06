import 'package:fake_lifecycle/src/tracker.dart';
import 'package:flutter/widgets.dart';

class LifecycleRouteObserver extends RouteObserver<Route<dynamic>> {
  LifecycleRouteObserver({
    @required LifecycleTracker tracker,
  })  : assert(tracker != null),
        _tracker = tracker;

  final LifecycleTracker _tracker;

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPush(route, previousRoute);
    if (previousRoute != null) {
      _tracker.trackPauseRoute(route: previousRoute);
    }
    if (route != null) {
      _tracker.trackStartRoute(route: route);
      _tracker.trackResumeRoute(route: route);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPop(route, previousRoute);
    if (route != null) {
      _tracker.trackPauseRoute(route: route);
      _tracker.trackStopRoute(route: route);
    }
    if (previousRoute != null) {
      _tracker.trackResumeRoute(route: previousRoute);
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    bool isCurrent = newRoute != null && newRoute.isCurrent;
    if (oldRoute != null) {
      if (isCurrent) {
        _tracker.trackPauseRoute(route: oldRoute);
      }
      _tracker.trackStopRoute(route: oldRoute);
    }
    if (newRoute != null) {
      _tracker.trackStartRoute(route: newRoute);
      if (isCurrent) {
        _tracker.trackResumeRoute(route: newRoute);
      }
    }
  }
}
