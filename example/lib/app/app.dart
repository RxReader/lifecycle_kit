import 'package:example/app/app_router.dart';
import 'package:example/app/router.dart';
import 'package:example/pages/home/home_page.dart';
import 'package:example/widgets/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lifecycle_kit/lifecycle_kit.dart';
import 'package:router_annotation/router_annotation.dart' as rca;

@rca.Manifest()
class App extends StatefulWidget {
  const App({
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return AppState();
  }

  static AppState of(BuildContext context) {
    AppState? app;
    if (context is StatefulElement && context.state is AppState) {
      app = context.state as AppState;
    }
    app = app ?? context.findAncestorStateOfType<AppState>();
    return app!;
  }
}

class AppState extends State<App> {
  static const List<String> _tabRoutes = <String>[
    HomePageProvider.routeName,
  ];

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  final LifecycleTracker _tracker = RouteTracker(
    onActive: (Route<dynamic> route) {
      if (route.settings.name?.isEmpty ?? true) {
        return;
      }
      if (!AppRouter.instance.names.containsKey(route.settings.name)) {
        return;
      }
      if (_tabRoutes.contains(route.settings.name)) {
        return;
      }
      if (kDebugMode) {
        print(
            'Analytics#onActive - ${route.settings.name} - ${AppRouter.instance.names[route.settings.name]}');
      }
    },
    onInactive: (Route<dynamic> route) {
      if (route.settings.name?.isEmpty ?? true) {
        return;
      }
      if (!AppRouter.instance.names.containsKey(route.settings.name)) {
        return;
      }
      if (_tabRoutes.contains(route.settings.name)) {
        return;
      }
      if (kDebugMode) {
        print(
            'Analytics#onInactive - ${route.settings.name} - ${AppRouter.instance.names[route.settings.name]}');
      }
    },
  );
  final RouteObserver<Route<dynamic>> _routeObserver =
      RouteObserver<Route<dynamic>>();
  final PowerfulRouteObserver<Route<dynamic>> _powerfulRouteObserver =
      PowerfulRouteObserver<Route<dynamic>>();

  LifecycleTracker get tracker => _tracker;

  RouteObserver<Route<dynamic>> get routeObserver => _routeObserver;

  PowerfulRouteObserver<Route<dynamic>> get powerfulRouteObserver =>
      _powerfulRouteObserver;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      onGenerateRoute: (RouteSettings settings) =>
          AppRouter.instance.onGenerateRoute(settings, _tracker),
      onUnknownRoute: (RouteSettings settings) =>
          AppRouter.instance.onUnknownRoute(settings, _tracker),
      navigatorObservers: <NavigatorObserver>[
        // LifecycleRouteObserver<Route<dynamic>>(
        //   tracker: _tracker,
        // ),
        LifecycleRouteObserver<Route<dynamic>>(
          tracker: RouteTracker(
            onInactive: (Route<dynamic> route) =>
                _tracker.trackInactive(route: route),
          ),
        ),
        _routeObserver,
        _powerfulRouteObserver,
        LifecycleRouteObserver<Route<dynamic>>(
          tracker: RouteTracker(
            onActive: (Route<dynamic> route) =>
                _tracker.trackActive(route: route),
          ),
        ),
      ],
      title: 'Lifecycle Kit',
      theme: ThemeData.light().copyWith(
        pageTransitionsTheme: PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
    );
  }

  Route<dynamic>? onGenerateRoute(RouteSettings settings) =>
      AppRouter.instance.onGenerateRoute(settings, _tracker);
}
