import 'package:example/app/app.dart';
import 'package:example/pages/profile/profile_page.dart';
import 'package:example/pages/todo/todo_page.dart';
import 'package:example/widgets/lifecycle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:router_annotation/router_annotation.dart' as rca;

part 'home_page.g.dart';

@rca.Page(
  name: '首页',
  routeName: Navigator.defaultRouteName,
)
class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final PageController _controller = PageController();
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LifecyclePageView(
        tracker: App.of(context).tracker,
        routeObserver: App.of(context).powerfulRouteObserver,
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        pages: <LifecyclePage>[
          LifecyclePage(
            name: TodoPageProvider.name,
            routeName: TodoPageProvider.routeName,
            routeBuilder: TodoPageProvider.routeBuilder,
          ),
          LifecyclePage(
            name: ProfilePageProvider.name,
            routeName: ProfilePageProvider.routeName,
            routeBuilder: ProfilePageProvider.routeBuilder,
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: CupertinoTabBar(
          items: <BottomNavigationBarItem>[
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
            setState(() {
              _page = index;
            });
          },
          currentIndex: _page,
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
