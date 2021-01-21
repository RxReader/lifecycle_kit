import 'package:flutter/material.dart';
import 'package:lifecycle_kit_example/pages/test/test_page.dart';
import 'package:router_annotation/router_annotation.dart' as rca;

part 'todo_page.g.dart';

@rca.Page(
  name: '待办',
  routeName: '/todo',
)
class TodoPage extends StatefulWidget {
  const TodoPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TodoPageState();
  }
}

class _TodoPageState extends State<TodoPage> with AutomaticKeepAliveClientMixin<TodoPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('待办'),
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
