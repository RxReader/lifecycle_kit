import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class IndicatorTapBuilder extends StatefulWidget {
  const IndicatorTapBuilder({
    Key key,
    @required this.builder,
    @required this.onTap,
  }) : super(key: key);

  final Widget Function(
      BuildContext context, bool showIndicator, VoidCallback onTap) builder;
  final AsyncCallback onTap;

  @override
  State<StatefulWidget> createState() {
    return _IndicatorTapBuilderState();
  }
}

class _IndicatorTapBuilderState extends State<IndicatorTapBuilder> {
  bool _executing = false;

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _executing,
        _executing || widget.onTap == null ? null : () => _onTap());
  }

  Future<void> _onTap() async {
    if (mounted) {
      setState(() {
        _executing = true;
      });
    }
    try {
      await widget.onTap?.call();
    } finally {
      if (mounted) {
        setState(() {
          _executing = false;
        });
      }
    }
  }
}
