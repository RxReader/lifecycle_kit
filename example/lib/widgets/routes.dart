import 'package:flutter/widgets.dart';

class PowerfulRouteAware {
  void didPush() {}

  void didPushNext() {}

  void didPopNext() {}

  void didPop() {}

  void didRemove(Route<dynamic>? previousRoute) {}

  void didReplace({Route<dynamic>? newRoute}) {}
}

class PowerfulRouteObserver<R extends Route<dynamic>>
    extends NavigatorObserver {
  final Map<R, Set<PowerfulRouteAware>> _listeners =
      <R, Set<PowerfulRouteAware>>{};

  /// Subscribe [routeAware] to be informed about changes to [route].
  ///
  /// Going forward, [routeAware] will be informed about qualifying changes
  /// to [route], e.g. when [route] is covered by another route or when [route]
  /// is popped off the [Navigator] stack.
  void subscribe(PowerfulRouteAware routeAware, R route) {
    final Set<PowerfulRouteAware> subscribers =
        _listeners.putIfAbsent(route, () => <PowerfulRouteAware>{});
    if (subscribers.add(routeAware)) {
      routeAware.didPush();
    }
  }

  /// Unsubscribe [routeAware].
  ///
  /// [routeAware] is no longer informed about changes to its route. If the given argument was
  /// subscribed to multiple types, this will unregister it (once) from each type.
  void unsubscribe(PowerfulRouteAware routeAware) {
    for (final R route in _listeners.keys) {
      final Set<PowerfulRouteAware>? subscribers = _listeners[route];
      subscribers?.remove(routeAware);
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route is R && previousRoute is R) {
      final Set<PowerfulRouteAware>? previousSubscribers =
          _listeners[previousRoute];

      if (previousSubscribers != null) {
        for (final PowerfulRouteAware routeAware in previousSubscribers) {
          routeAware.didPushNext();
        }
      }
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route is R && previousRoute is R) {
      final List<PowerfulRouteAware>? previousSubscribers =
          _listeners[previousRoute]?.toList();

      if (previousSubscribers != null) {
        for (final PowerfulRouteAware routeAware in previousSubscribers) {
          routeAware.didPopNext();
        }
      }

      final List<PowerfulRouteAware>? subscribers = _listeners[route]?.toList();

      if (subscribers != null) {
        for (final PowerfulRouteAware routeAware in subscribers) {
          routeAware.didPop();
        }
      }
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route is R) {
      final List<PowerfulRouteAware>? subscribers = _listeners[route]?.toList();
      if (subscribers != null) {
        for (final PowerfulRouteAware routeAware in subscribers) {
          routeAware.didRemove(previousRoute);
        }
      }
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (oldRoute is R) {
      final List<PowerfulRouteAware>? oldSubscribers =
          _listeners[oldRoute]?.toList();
      if (oldSubscribers != null) {
        for (final PowerfulRouteAware routeAware in oldSubscribers) {
          routeAware.didReplace(newRoute: newRoute);
        }
      }
    }
  }
}
