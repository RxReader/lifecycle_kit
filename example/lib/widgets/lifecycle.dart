import 'package:flutter/material.dart';
import 'package:lifecycle_kit/lifecycle_kit.dart';

class LifecyclePage extends StatefulWidget {
  const LifecyclePage({
    Key? key,
    required this.tracker,
    required this.routeName,
    required this.routeBuilder,
    required this.routeObserver,
  }) : super(key: key);

  final LifecycleTracker tracker;
  final String routeName;
  final WidgetBuilder routeBuilder;
  final RouteObserver<Route<dynamic>> routeObserver;

  @override
  State<StatefulWidget> createState() {
    return _LifecyclePageState();
  }
}

class _LifecyclePageState extends State<LifecyclePage> with RouteAware, WidgetsBindingObserver {
  //
  int? _page;
  int? _selectedPage;
  PageController? _controller;

  //
  ModalRoute<dynamic>? _route;
  ModalRoute<dynamic>? _pageRoute;
  RouteObserver<Route<dynamic>>? _routeObserver;

  int? get _currentPage {
    if (_controller == null) {
      return null;
    }
    if (_controller!.hasClients && _controller!.position.haveDimensions) {
      return _controller!.page?.round() ?? _controller!.initialPage;
    }
    return _controller!.initialPage;
  }

  bool get _isCurrent => _page != null && _currentPage != null && _currentPage == _page;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //
    _page ??= context.findAncestorWidgetOfExactType<IndexedSemantics>()!.index;
    _controller?.removeListener(_listenPageChange); // TabBarView 的 didChangeDependencies 会频繁创建 PageController
    _controller = Scrollable.of(context)!.widget.controller as PageController;
    _controller!.addListener(_listenPageChange);
    //
    _route ??= ModalRoute.of(context);
    _pageRoute ??= PageRouteBuilder<dynamic>(
      settings: _route!.settings.copyWith(name: widget.routeName),
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => widget.routeBuilder.call(context),
    );
    _routeObserver ??= widget.routeObserver..subscribe(this, _route!);
  }

  void _listenPageChange() {
    int? currentPage = _currentPage;
    if (currentPage != _selectedPage) {
      if (currentPage == _page) {
        widget.tracker.trackActive(route: _pageRoute!);
      } else if (_selectedPage == null || _selectedPage == _page) {
        widget.tracker.trackInactive(route: _pageRoute!);
      }
    }
    _selectedPage = currentPage;
  }

  @override
  void dispose() {
    _routeObserver?.unsubscribe(this);
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  // --- RouteAware

  @override
  void didPush() {
    // super.didPush();
    if (_isCurrent) {
      widget.tracker.trackActive(route: _pageRoute!);
    }
  }

  @override
  void didPushNext() {
    // super.didPushNext();
    if (_isCurrent) {
      widget.tracker.trackInactive(route: _pageRoute!);
    }
  }

  @override
  void didPopNext() {
    // super.didPopNext();
    if (_isCurrent) {
      widget.tracker.trackActive(route: _pageRoute!);
    }
  }

  @override
  void didPop() {
    // super.didPop();
    if (_isCurrent) {
      widget.tracker.trackInactive(route: _pageRoute!);
    }
  }

  // --- WidgetsBindingObserver

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // super.didChangeAppLifecycleState(state);
    if (_route?.isCurrent ?? false) {
      if (state == AppLifecycleState.resumed) {
        if (_isCurrent) {
          widget.tracker.trackActive(route: _pageRoute!);
        }
      } else if (state == AppLifecycleState.inactive) {
        // AppLifecycleState.paused
        if (_isCurrent) {
          widget.tracker.trackInactive(route: _pageRoute!);
        }
      }
    }
  }

  // ---

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: widget.routeBuilder,
    );
  }
}
