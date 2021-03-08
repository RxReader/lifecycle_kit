import 'package:flutter/material.dart';
import 'package:router_annotation/router_annotation.dart' as rca;

part 'not_found_page.g.dart';

@rca.Page(
  name: '404',
  routeName: '/not_found',
)
class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('404 Page Not Found!'),
      ),
    );
  }
}
