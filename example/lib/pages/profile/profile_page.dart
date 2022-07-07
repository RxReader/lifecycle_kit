import 'package:example/app/app.dart';
import 'package:example/app/app_router.dart';
import 'package:example/pages/test/test_page.dart';
import 'package:example/widgets/lifecycle.dart';
import 'package:flutter/material.dart';
import 'package:router_annotation/router_annotation.dart' as rca;

part 'profile_page.g.dart';

@rca.Page(
  name: '我的',
  routeName: '/profile',
)
class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin<ProfilePage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
      ),
      body: LifecyclePageView(
        tracker: App.of(context).tracker,
        routeObserver: App.of(context).powerfulRouteObserver,
        pages: <LifecyclePage>[
          LifecyclePage(
            routeName: '${ProfilePageProvider.routeName}/1',
            routeBuilder: (BuildContext context) {
              return ListView(
                children: <Widget>[
                  ListTile(
                    title: Text('Test Profile 1'),
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
            routeName: '${ProfilePageProvider.routeName}/2',
            routeBuilder: (BuildContext context) {
              return ListView(
                children: <Widget>[
                  ListTile(
                    title: Text('Test Profile 2'),
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
