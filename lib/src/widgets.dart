import 'package:flutter/widgets.dart';
import 'package:lifecycle_kit/src/tracker.dart';

class LifecycleWidget extends StatefulWidget {
  const LifecycleWidget({
    Key key,
    @required this.tracker,
    @required this.child,
  })  : assert(tracker != null),
        assert(child != null),
        super(key: key);

  final LifecycleTracker tracker;
  final Widget child;

  @override
  State<StatefulWidget> createState() {
    return _LifecycleWidgetState();
  }
}

class _LifecycleWidgetState extends State<LifecycleWidget> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    Route<dynamic> route = ModalRoute.of<dynamic>(context);
    if (route.isCurrent) {
      if (state == AppLifecycleState.resumed) {
        widget.tracker.trackActive(route: route);
      } else if (state == AppLifecycleState.inactive) {
        // AppLifecycleState.paused
        widget.tracker.trackInactive(route: route);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
