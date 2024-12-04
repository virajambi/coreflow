import 'package:flutter/widgets.dart';

class CoreFlow<T> extends InheritedWidget {
  final T state;
  final void Function(T newState) update;

  CoreFlow({
    Key? key,
    required this.state,
    required this.update,
    required Widget child,
  }) : super(key: key, child: child);

  // retrieving the state from the widget tree
  static CoreFlow<T> of<T>(BuildContext context) {
    final CoreFlow<T>? flow = context.dependOnInheritedWidgetOfExactType<CoreFlow<T>>();
    if (flow == null) {
      throw FlutterError('no coreflow state found in the widget tree for type $T');
    }
    return flow;
  }

  @override
  bool updateShouldNotify(CoreFlow<T> oldWidget) {
    return oldWidget.state != state;
  }
}
