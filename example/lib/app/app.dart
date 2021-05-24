import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lifecycle_kit/lifecycle_kit.dart';
import 'package:lifecycle_kit_example/app/app_router.dart';
import 'package:lifecycle_kit_example/pages/home/home_page.dart';
import 'package:lifecycle_kit_example/pages/not_found/not_found_page.dart';
import 'package:lifecycle_kit_example/widgets/routes.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

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
  static const List<String> _fadeAnimRoutes = <String>[];
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
        print('Analytics#onActive - ${route.settings.name} - ${AppRouter.instance.names[route.settings.name]}');
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
        print('Analytics#onInactive - ${route.settings.name} - ${AppRouter.instance.names[route.settings.name]}');
      }
    },
  );
  final RouteObserver<Route<dynamic>> _routeObserver = RouteObserver<Route<dynamic>>();
  final PowerfulRouteObserver<Route<dynamic>> _powerfulRouteObserver = PowerfulRouteObserver<Route<dynamic>>();

  LifecycleTracker get tracker => _tracker;

  RouteObserver<Route<dynamic>> get routeObserver => _routeObserver;

  PowerfulRouteObserver<Route<dynamic>> get powerfulRouteObserver => _powerfulRouteObserver;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      onGenerateRoute: onGenerateRoute,
      onUnknownRoute: _onUnknownRoute,
      navigatorObservers: <NavigatorObserver>[
        LifecycleRouteObserver<Route<dynamic>>(
          tracker: _tracker,
        ),
        _routeObserver,
      ],
      title: 'lifecycle_kit',
    );
  }

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (AppRouter.instance.routes.containsKey(settings.name)) {
      if (_fadeAnimRoutes.contains(settings.name)) {
        return PageRouteBuilder<dynamic>(
          settings: settings,
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return _routeWidget(context, settings, settings.name!);
          },
          transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.linear,
              ),
              child: child,
            );
          },
        );
      }
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => _routeWidget(context, settings, settings.name!),
        settings: settings,
      );
    }
    return null;
  }

  Route<dynamic> _onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute<dynamic>(
      builder: (BuildContext context) => _routeWidget(context, settings, NotFoundPageProvider.routeName),
      settings: settings,
    );
  }

  Widget _routeWidget(BuildContext context, RouteSettings settings, String routeName) {
    return LifecycleWidget(
      tracker: _tracker,
      child: Builder(
        builder: AppRouter.instance.routes[routeName]!,
      ),
    );
  }
}
