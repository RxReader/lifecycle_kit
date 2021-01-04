import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifecycle_kit/lifecycle_kit.dart';
import 'package:lifecycle_kit_example/app/app.dart';
import 'package:lifecycle_kit_example/app/app.manifest.g.dart';
import 'package:lifecycle_kit_example/pages/not_found/not_found_page.dart';
import 'package:router_annotation/router_annotation.dart' as rca;

part 'test_page.g.dart';

@rca.Page(
  name: '测试',
  routeName: '/test',
)
class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('测试'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Test'),
            onTap: () {
              Navigator.of(context).pushNamed(TestPageProvider.routeName);
            },
          ),
          ListTile(
            title: const Text('pop'),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: const Text('popAndPushNamed'),
            onTap: () {
              Navigator.of(context)
                  .popAndPushNamed(NotFoundPageProvider.routeName);
            },
          ),
          ListTile(
            title: const Text('popUntil'),
            onTap: () {
              Navigator.of(context)
                  .popUntil(ModalRoute.withName(Navigator.defaultRouteName));
            },
          ),
          ListTile(
            title: const Text('push/pushNamed'),
            onTap: () {
              Navigator.of(context).pushNamed(NotFoundPageProvider.routeName);
            },
          ),
          ListTile(
            title: const Text('pushAndRemoveUntil/pushNamedAndRemoveUntil'),
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  NotFoundPageProvider.routeName,
                  ModalRoute.withName(Navigator.defaultRouteName));
            },
          ),
          ListTile(
            title: const Text('pushReplacement/pushReplacementNamed'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(NotFoundPageProvider.routeName);
            },
          ),
          ListTile(
            title: const Text('removeRoute'),
            onTap: () {
              Navigator.of(context).removeRoute(ModalRoute.of(context));
            },
          ),
          ListTile(
            title: const Text('removeRouteBelow - 不支持'),
            onTap: () {
              throw UnsupportedError('LifecycleObserver 不支持');
            },
          ),
          ListTile(
            title: const Text('replace/replaceRouteBelow'),
            onTap: () {
              Navigator.of(context).replaceRouteBelow<dynamic>(
                anchorRoute: ModalRoute.of<dynamic>(context),
                newRoute: App.of(context).onGenerateRoute(const RouteSettings(
                  name: NotFoundPageProvider.routeName,
                )),
              );
            },
          ),
        ],
      ),
    );
  }
}
