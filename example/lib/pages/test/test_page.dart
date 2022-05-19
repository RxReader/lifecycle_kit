import 'package:example/app/app.dart';
import 'package:example/pages/not_found/not_found_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:router_annotation/router_annotation.dart' as rca;

part 'test_page.g.dart';

@rca.Page(
  name: '测试',
  routeName: '/test',
)
class TestPage extends StatelessWidget {
  const TestPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('测试'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Test'),
            onTap: () {
              Navigator.of(context).pushNamed(TestPageProvider.routeName);
            },
          ),
          ListTile(
            title: Text('pop'),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: Text('popAndPushNamed'),
            onTap: () {
              Navigator.of(context)
                  .popAndPushNamed(NotFoundPageProvider.routeName);
            },
          ),
          ListTile(
            title: Text('popUntil'),
            onTap: () {
              Navigator.of(context)
                  .popUntil(ModalRoute.withName(Navigator.defaultRouteName));
            },
          ),
          ListTile(
            title: Text('push/pushNamed'),
            onTap: () {
              Navigator.of(context).pushNamed(NotFoundPageProvider.routeName);
            },
          ),
          ListTile(
            title: Text('pushAndRemoveUntil/pushNamedAndRemoveUntil'),
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  NotFoundPageProvider.routeName,
                  ModalRoute.withName(Navigator.defaultRouteName));
            },
          ),
          ListTile(
            title: Text('pushReplacement/pushReplacementNamed'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(NotFoundPageProvider.routeName);
            },
          ),
          ListTile(
            title: Text('removeRoute'),
            onTap: () {
              Navigator.of(context).removeRoute(ModalRoute.of(context)!);
            },
          ),
          ListTile(
            title: Text('removeRouteBelow'),
            onTap: () {
              Navigator.of(context).removeRouteBelow(ModalRoute.of(context)!);
            },
          ),
          ListTile(
            title: Text('replace/replaceRouteBelow'),
            onTap: () {
              Navigator.of(context).replaceRouteBelow<dynamic>(
                anchorRoute: ModalRoute.of(context)!,
                newRoute: App.of(context).onGenerateRoute(const RouteSettings(
                  name: NotFoundPageProvider.routeName,
                ))!,
              );
            },
          ),
        ],
      ),
    );
  }
}
