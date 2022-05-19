import 'package:flutter/widgets.dart';
import 'package:lifecycle_kit/src/tracker.dart';

class LifecycleWidget extends StatefulWidget {
  const LifecycleWidget({
    super.key,
    required this.tracker,
    required this.child,
  });

  final LifecycleTracker tracker;
  final Widget child;

  @override
  State<StatefulWidget> createState() {
    return _LifecycleWidgetState();
  }
}

class _LifecycleWidgetState extends State<LifecycleWidget>
    with WidgetsBindingObserver {
  Route<dynamic>? _route;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _route ??= ModalRoute.of<dynamic>(context);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (_route?.isCurrent ?? false) {
      if (state == AppLifecycleState.resumed) {
        widget.tracker.trackActive(route: _route!);
      } else if (state == AppLifecycleState.inactive) {
        // AppLifecycleState.paused
        widget.tracker.trackInactive(route: _route!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
