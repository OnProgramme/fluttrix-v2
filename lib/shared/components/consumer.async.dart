import 'package:flutter/widgets.dart';

class ConsumerAsync<T extends ChangeNotifier> extends StatefulWidget {
  final List<T> notifier;
  final Widget Function(BuildContext context, List<T> async) builder;

  const ConsumerAsync({
    super.key,
    required this.notifier,
    required this.builder,
  });

  @override
  State<ConsumerAsync<T>> createState() => _ConsumerAsyncState<T>();
}

class _ConsumerAsyncState<T extends ChangeNotifier>
    extends State<ConsumerAsync<T>> {
  @override
  void initState() {
    super.initState();
    for (var action in widget.notifier) {
      action.addListener(_onNotifierChanged);
    }
  }

  @override
  void dispose() {
    for (var action in widget.notifier) {
      action.removeListener(_onNotifierChanged);
    }    super.dispose();
  }

  void _onNotifierChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.notifier);
  }
}
