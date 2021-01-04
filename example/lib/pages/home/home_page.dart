import 'package:flutter/material.dart';
import 'package:lifecycle_kit_example/pages/test/test_page.dart';
import 'package:router_annotation/router_annotation.dart' as rca;

part 'home_page.g.dart';

@rca.Page(
  name: '首页',
  routeName: Navigator.defaultRouteName,
)
class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Test'),
            onTap: () {
              TestPageProvider.pushByNamed(context);
            },
          ),
        ],
      ),
    );
  }
}
