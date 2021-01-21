import 'package:flutter/material.dart';
import 'package:router_annotation/router_annotation.dart' as rca;

part 'profile_page.g.dart';

@rca.Page(
  name: '我的',
  routeName: '/profile',
)
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

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
        title: const Text('我的'),
      ),
    );
  }
}
