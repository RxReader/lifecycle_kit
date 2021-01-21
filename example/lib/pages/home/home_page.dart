import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifecycle_kit_example/app/app.dart';
import 'package:lifecycle_kit_example/pages/profile/profile_page.dart';
import 'package:lifecycle_kit_example/pages/todo/todo_page.dart';
import 'package:lifecycle_kit_example/widgets/lifecycle.dart';
import 'package:router_annotation/router_annotation.dart' as rca;

part 'home_page.g.dart';

@rca.Page(
  name: '首页',
  routeName: Navigator.defaultRouteName,
)
class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          LifecyclePage(
            tracker: App.of(context).tracker,
            routeName: TodoPageProvider.routeName,
            routeBuilder: TodoPageProvider.routeBuilder,
            routeObserver: App.of(context).routeObserver,
          ),
          LifecyclePage(
            tracker: App.of(context).tracker,
            routeName: ProfilePageProvider.routeName,
            routeBuilder: ProfilePageProvider.routeBuilder,
            routeObserver: App.of(context).routeObserver,
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: CupertinoTabBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.edit),
              label: '待办',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: '我的',
            ),
          ],
          onTap: (int index) {
            _controller.jumpToPage(index);
          },
          backgroundColor: Theme.of(context).bottomAppBarTheme.color,
          border: Border.all(
            color: Colors.transparent,
            width: 0.0,
          ),
        ),
      ),
    );
  }
}
