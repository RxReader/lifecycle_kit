import 'package:meta/meta.dart';
import 'package:flutter/widgets.dart';

abstract class LifecycleTracker {
  void trackStartRoute({@required Route<dynamic> route});

  void trackResumeRoute({@required Route<dynamic> route});

  void trackPauseRoute({@required Route<dynamic> route});

  void trackStopRoute({@required Route<dynamic> route});
}
