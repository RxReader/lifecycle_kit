import 'package:flutter/material.dart';
import 'package:lifecycle_kit/lifecycle_kit.dart';

class RouteTracker implements LifecycleTracker {
  const RouteTracker({
    this.onActive,
    this.onInactive,
  });

  final void Function(Route<dynamic> route) onActive;
  final void Function(Route<dynamic> route) onInactive;

  @override
  void trackActive({Route<dynamic> route}) {
    onActive?.call(route);
  }

  @override
  void trackInactive({Route<dynamic> route}) {
    onInactive?.call(route);
  }
}
