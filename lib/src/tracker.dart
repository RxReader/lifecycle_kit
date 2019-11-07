import 'package:flutter/widgets.dart';

abstract class LifecycleTracker {
  void trackStart({@required Route<dynamic> route});

  void trackResume({@required Route<dynamic> route});

  void trackPause({@required Route<dynamic> route});

  void trackStop({@required Route<dynamic> route});
}
