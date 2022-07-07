import 'package:example/app/app.dart';
import 'package:example/app/app_router.dart';
import 'package:example/pages/test/test_page.dart';
import 'package:example/widgets/lifecycle.dart';
import 'package:flutter/material.dart';
import 'package:router_annotation/router_annotation.dart' as rca;

part 'todo_page.g.dart';

@rca.Page(
  name: '待办',
  routeName: '/todo',
)
class TodoPage extends StatefulWidget {
  const TodoPage({
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _TodoPageState();
  }
}

class _TodoPageState extends State<TodoPage>
    with AutomaticKeepAliveClientMixin<TodoPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('待办'),
      ),
      body: LifecyclePageView(
        tracker: App.of(context).tracker,
        routeObserver: App.of(context).powerfulRouteObserver,
        pages: <LifecyclePage>[
          LifecyclePage(
            routeName: '${TodoPageProvider.routeName}/1',
            routeBuilder: (BuildContext context) {
              return ListView(
                children: <Widget>[
                  ListTile(
                    title: Text('Test Todo 1'),
                    onTap: () {
                      AppRouter.instance
                          .pushNamed(context, TestPageProvider.routeName);
                    },
                  ),
                ],
              );
            },
          ),
          LifecyclePage(
            routeName: '${TodoPageProvider.routeName}/2',
            routeBuilder: (BuildContext context) {
              return ListView(
                children: <Widget>[
                  ListTile(
                    title: Text('Test Todo 2'),
                    onTap: () {
                      AppRouter.instance
                          .pushNamed(context, TestPageProvider.routeName);
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
