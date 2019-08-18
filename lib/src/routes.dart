import 'package:fake_lifecycle/src/tracker.dart';
import 'package:flutter/widgets.dart';

class LifecycleRouteObserver extends RouteObserver<Route<dynamic>> {
  LifecycleRouteObserver({
    @required LifecycleTracker tracker,
  })  : assert(tracker != null),
        _tracker = tracker;

  final LifecycleTracker _tracker;
  final List<Route<dynamic>> _history = <Route<dynamic>>[];

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPush(route, previousRoute);
    previousRoute = _history.isNotEmpty ? _history.last : null;
    if (previousRoute != null) {
      _tracker.trackPauseRoute(route: previousRoute);
    }
    _tracker.trackStartRoute(route: route);
    _tracker.trackResumeRoute(route: route);
    _history.add(route);
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
    if (route != null) {
      _history.remove(route);
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didRemove(route, previousRoute);
    if ((previousRoute == null && ) || previousRoute.isCurrent) {
      _tracker.trackPauseRoute(route: route);
    }
    _tracker.trackStopRoute(route: route);

    if (previousRoute != null) {
      if (previousRoute.isCurrent) {
        _tracker.trackResumeRoute(route: previousRoute);
      }
    }

    _history.remove(route);
  }

  @override
  void didReplace({@required Route<dynamic> newRoute, @required Route<dynamic> oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute.isCurrent) {
      _tracker.trackPauseRoute(route: oldRoute);
    }
    _tracker.trackStopRoute(route: oldRoute);
    _tracker.trackStartRoute(route: newRoute);
    if (newRoute.isCurrent) {
      _tracker.trackResumeRoute(route: newRoute);
    }
    _history[_history.indexOf(oldRoute)] = newRoute;
  }
}
