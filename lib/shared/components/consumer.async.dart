import 'package:flutter/widgets.dart';
import 'package:fluttrix/shared/usecases/usecase.dart';

class ConsumerAsync<T extends UseCaseWithoutCommand> extends StatefulWidget {
  final List<UseCase> notifier;
  final Widget Function(BuildContext context, List<UseCase> async)
      builder;

  const ConsumerAsync({
    super.key,
    required this.notifier,
    required this.builder,
  });

  @override
  State<ConsumerAsync> createState() => _ConsumerAsyncState();
}

class _ConsumerAsyncState extends State<ConsumerAsync> {
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
    }
    super.dispose();
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
