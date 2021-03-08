import 'package:flutter/widgets.dart';

abstract class LifecycleTracker {
  void trackActive({required Route<dynamic> route});

  void trackInactive({required Route<dynamic> route});
}
