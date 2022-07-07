import 'package:example/widgets/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lifecycle_kit/lifecycle_kit.dart';
import 'package:router_api/router_api.dart' as ra;

class LifecycleFuncTracker implements LifecycleTracker {
  const LifecycleFuncTracker({
    this.onActive,
    this.onInactive,
  });

  final void Function(Route<dynamic> route)? onActive;
  final void Function(Route<dynamic> route)? onInactive;

  @override
  void trackActive({required Route<dynamic> route}) {
    onActive?.call(route);
  }

  @override
  void trackInactive({required Route<dynamic> route}) {
    onInactive?.call(route);
  }
}

class LifecyclePage {
  const LifecyclePage({
    required this.name,
    required this.routeName,
    required this.routeBuilder,
  });

  factory LifecyclePage.fromController(dynamic controller) {
    final ra.Controller wrapper = ra.Controller.from(controller);
    return LifecyclePage(
      name: wrapper.name,
      routeName: wrapper.routeName,
      routeBuilder: wrapper.routeBuilder,
    );
  }

  final String name;
  final String routeName;
  final WidgetBuilder routeBuilder;
}

extension LifecyclePageRouteSettings on RouteSettings {
  bool get isLifecyclePage =>
      (arguments as Map<String, dynamic>?)
          ?.containsKey('_lifecycle_page_|_name_') ??
      false;

  String? get lifecyclePageName =>
      (arguments as Map<String, dynamic>?)?['_lifecycle_page_|_name_']
          as String?;
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
  }) : controller = controller ?? PageController(initialPage: 0);

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

class _LifecyclePageViewState extends State<LifecyclePageView>
    with PowerfulRouteAware, WidgetsBindingObserver {
  late final LifecycleTracker _tracker = LifecycleFuncTracker(
    onActive: (Route<dynamic> route) {
      widget.tracker.trackActive(route: route);
      final int index = _pageRoutes!.indexOf(route);
      _childActiveTracker[index]?.call();
    },
    onInactive: (Route<dynamic> route) {
      widget.tracker.trackInactive(route: route);
      final int index = _pageRoutes!.indexOf(route);
      _childInactiveTracker[index]?.call();
    },
  );

  //
  late int _selectedIndex = widget.controller.initialPage;

  //
  Route<dynamic>? _route;
  List<Route<dynamic>>? _pageRoutes;
  PowerfulRouteObserver<Route<dynamic>>? _routeObserver;

  //
  _LifecyclePageViewState? _ancestor;
  IndexedSemantics? _indexed;
  final Map<int, VoidCallback> _childActiveTracker = <int, VoidCallback>{};
  final Map<int, VoidCallback> _childInactiveTracker = <int, VoidCallback>{};

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
        settings: RouteSettings(
          name: element.routeName,
          arguments: <String, dynamic>{
            '_lifecycle_page_|_name_': element.name,
          },
        ),
        pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) =>
            element.routeBuilder.call(context),
      );
    }).toList();
    _routeObserver ??= widget.routeObserver..subscribe(this, _route!);
    _updateAncestor(); // 要晚于 routeObserver.subscribe
  }

  void _updateAncestor() {
    final _LifecyclePageViewState? newAncestor =
        context.findAncestorStateOfType<_LifecyclePageViewState>();
    if (newAncestor == _ancestor) {
      return;
    }
    if (_ancestor != null) {
      final int index = _indexed!.index;
      _indexed = null;
      _ancestor!._childActiveTracker.remove(index);
      _ancestor!._childInactiveTracker.remove(index);
    }
    _ancestor = newAncestor;
    if (_ancestor != null) {
      _indexed = context.findAncestorWidgetOfExactType<IndexedSemantics>();
      final int index = _indexed!.index;
      _ancestor!._childActiveTracker[index] = () {
        _tracker.trackActive(route: _pageRoutes![_selectedIndex]);
      };
      _ancestor!._childInactiveTracker[index] = () {
        _tracker.trackInactive(route: _pageRoutes![_selectedIndex]);
      };
    }
  }

  @override
  void dispose() {
    _routeObserver?.unsubscribe(this);
    if (_ancestor != null) {
      final int index = _indexed!.index;
      _indexed = null;
      _ancestor!._childActiveTracker.remove(index);
      _ancestor!._childInactiveTracker.remove(index);
    }
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // --- RouteAware

  @override
  void didPush() {
    // super.didPush();
    if (_route?.isCurrent ?? false) {
      _tracker.trackActive(route: _pageRoutes![_selectedIndex]);
    }
  }

  @override
  void didPushNext() {
    // super.didPushNext();
    // if (_route?.isCurrent ?? false) {// false
    if (_ancestor == null) {
      _tracker.trackInactive(route: _pageRoutes![_selectedIndex]);
    }
    // }
  }

  @override
  void didPopNext() {
    // super.didPopNext();
    // if (_route?.isCurrent ?? false) {// true
    if (_ancestor == null) {
      _tracker.trackActive(route: _pageRoutes![_selectedIndex]);
    }
    // }
  }

  @override
  void didPop() {
    // super.didPop();
    // if (_route?.isCurrent ?? false) {
    if (_ancestor == null) {
      _tracker.trackInactive(route: _pageRoutes![_selectedIndex]);
    }
    // }
  }

  @override
  void didRemove(Route<dynamic>? previousRoute) {
    // super.didRemove(previousRoute);
    if (previousRoute?.isCurrent ?? false) {
      if (_ancestor == null) {
        _tracker.trackInactive(route: _pageRoutes![_selectedIndex]);
      }
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute}) {
    // super.didReplace(newRoute: newRoute);
    if (newRoute?.isCurrent ?? false) {
      if (_ancestor == null) {
        _tracker.trackInactive(route: _pageRoutes![_selectedIndex]);
      }
    }
  }

  // --- WidgetsBindingObserver

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // super.didChangeAppLifecycleState(state);
    if (_route?.isCurrent ?? false) {
      if (_ancestor == null) {
        if (state == AppLifecycleState.resumed) {
          _tracker.trackActive(route: _pageRoutes![_selectedIndex]);
        } else if (state == AppLifecycleState.inactive) {
          // AppLifecycleState.paused
          _tracker.trackInactive(route: _pageRoutes![_selectedIndex]);
        }
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
        if (_ancestor == null || _ancestor!._selectedIndex == _indexed!.index) {
          _tracker.trackInactive(route: _pageRoutes![_selectedIndex]);
          _tracker.trackActive(route: _pageRoutes![index]);
        }
      }
      _selectedIndex = index;
    }
    widget.onPageChanged?.call(index);
  }
}
