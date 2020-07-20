import 'package:flutter/widgets.dart';
import 'package:lifecycle_kit/src/tracker.dart';

class LifecycleRouteObserver<R extends Route<dynamic>>
    extends RouteObserver<R> {
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
      _tracker.trackPause(route: previousRoute);
    }
    _tracker.trackStart(route: route);
    _tracker.trackResume(route: route);
    _history.add(route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPop(route, previousRoute);
    _tracker.trackPause(route: route);
    _tracker.trackStop(route: route);
    if (previousRoute != null) {
      _tracker.trackResume(route: previousRoute);
    }
    _history.remove(route);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didRemove(route, previousRoute);
    if ((previousRoute != null && previousRoute.isCurrent) ||
        route == _history.last) {
      _tracker.trackPause(route: route);
    }
    _tracker.trackStop(route: route);
    if (previousRoute != null && previousRoute.isCurrent) {
      _tracker.trackResume(route: previousRoute);
    }
    _history.remove(route);
  }

  @override
  void didReplace(
      {@required Route<dynamic> newRoute, @required Route<dynamic> oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute.isCurrent) {
      _tracker.trackPause(route: oldRoute);
    }
    _tracker.trackStop(route: oldRoute);
    _tracker.trackStart(route: newRoute);
    if (newRoute.isCurrent) {
      _tracker.trackResume(route: newRoute);
    }
    _history[_history.indexOf(oldRoute)] = newRoute;
  }
}
