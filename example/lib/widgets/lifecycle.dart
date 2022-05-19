import 'package:example/widgets/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifecycle_kit/lifecycle_kit.dart';

class LifecyclePage {
  const LifecyclePage({
    required this.routeName,
    required this.routeBuilder,
  });

  final String routeName;
  final WidgetBuilder routeBuilder;
}

class LifecyclePageView extends StatefulWidget {
  LifecyclePageView({
    super.key,
    this.restorationId,
    required this.tracker,
    required this.routeObserver,
    PageController? controller,
    this.physics,
    this.onPageChanged,
    required this.pages,
  })  : controller = controller ?? PageController(initialPage: 0);

  final String? restorationId;
  final LifecycleTracker tracker;
  final PowerfulRouteObserver<Route<dynamic>> routeObserver;
  final PageController controller;
  final ScrollPhysics? physics;
  final ValueChanged<int>? onPageChanged;
  final List<LifecyclePage> pages;

  @override
  State<StatefulWidget> createState() {
    return _LifecyclePageViewState();
  }
}

class _LifecyclePageViewState extends State<LifecyclePageView> with PowerfulRouteAware, WidgetsBindingObserver {
  //
  late int _selectedIndex = widget.controller.initialPage;

  //
  ModalRoute<dynamic>? _route;
  List<ModalRoute<dynamic>>? _pageRoutes;
  PowerfulRouteObserver<Route<dynamic>>? _routeObserver;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _route ??= ModalRoute.of(context);
    _pageRoutes ??= widget.pages.map((LifecyclePage element) {
      return PageRouteBuilder<dynamic>(
        settings: _route!.settings.copyWith(name: element.routeName),
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => element.routeBuilder.call(context),
      );
    }).toList();
    _routeObserver ??= widget.routeObserver..subscribe(this, _route!);
  }

  @override
  void dispose() {
    _routeObserver?.unsubscribe(this);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // --- RouteAware

  @override
  void didPush() {
    // super.didPush();
    if (_route?.isCurrent ?? false) {
      widget.tracker.trackActive(route: _pageRoutes![_selectedIndex]);
    }
  }

  @override
  void didPushNext() {
    // super.didPushNext();
    // if (_route?.isCurrent ?? false) {// false
      widget.tracker.trackInactive(route: _pageRoutes![_selectedIndex]);
    // }
  }

  @override
  void didPopNext() {
    // super.didPopNext();
    // if (_route?.isCurrent ?? false) {// true
      widget.tracker.trackActive(route: _pageRoutes![_selectedIndex]);
    // }
  }

  @override
  void didPop() {
    // super.didPop();
    // if (_route?.isCurrent ?? false) {
      widget.tracker.trackInactive(route: _pageRoutes![_selectedIndex]);
    // }
  }

  @override
  void didRemove(Route<dynamic>? previousRoute) {
    // super.didRemove(previousRoute);
    if (previousRoute?.isCurrent ?? false) {
      widget.tracker.trackInactive(route: _pageRoutes![_selectedIndex]);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute}) {
    // super.didReplace(newRoute: newRoute);
    if (newRoute?.isCurrent ?? false) {
      widget.tracker.trackInactive(route: _pageRoutes![_selectedIndex]);
    }
  }

  // --- WidgetsBindingObserver

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // super.didChangeAppLifecycleState(state);
    if (_route?.isCurrent ?? false) {
      if (state == AppLifecycleState.resumed) {
        widget.tracker.trackActive(route: _pageRoutes![_selectedIndex]);
      } else if (state == AppLifecycleState.inactive) {
        // AppLifecycleState.paused
        widget.tracker.trackInactive(route: _pageRoutes![_selectedIndex]);
      }
    }
  }

  // ---

  @override
  Widget build(BuildContext context) {
    return PageView(
      restorationId: widget.restorationId,
      controller: widget.controller,
      physics: widget.physics,
      onPageChanged: _onPageChanged,
      children: widget.pages.map((LifecyclePage element) {
        return element.routeBuilder.call(context);
      }).toList(),
    );
  }

  void _onPageChanged(int index) {
    if (_selectedIndex != index) {
      if (_route?.isCurrent ?? false) {
        widget.tracker.trackInactive(route: _pageRoutes![_selectedIndex]);
        widget.tracker.trackActive(route: _pageRoutes![index]);
      }
      _selectedIndex = index;
    }
    widget.onPageChanged?.call(index);
  }
}
