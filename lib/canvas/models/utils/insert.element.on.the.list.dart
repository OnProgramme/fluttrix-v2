import 'package:fluttrix/canvas/models/enums/drop.position.dart';

void insertElementOnTheList<T>({
  required List<T> list,
  required T element,
  required int index,
  required DropPosition position,
}) {
  print('index: $index list: ${list.length} ${index < 0 || index >= list.length}');
  if (index < 0 || index >= list.length) {
    return;
  }
  final insertionIndex = position == DropPosition.BEFORE ? index : index + 1;
  list.insert(insertionIndex, element);
}