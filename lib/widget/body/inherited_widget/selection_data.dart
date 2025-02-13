import 'package:flutter/material.dart';

class SelectionData extends InheritedWidget {
  final DiagramSelectionDetails details;

  Rect? get rect => details.isSelecting
      ? Rect.fromPoints(details.start, details.current)
      : null;

  const SelectionData({
    super.key,
    required this.details,
    required super.child,
  });

  static SelectionData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SelectionData>();
  }

  @override
  bool updateShouldNotify(SelectionData oldWidget) {
    // Return true when the data has changed and needs to notify dependent widgets
    return details != oldWidget.details;
  }
}

@immutable
class DiagramSelectionDetails {
  final Offset start;
  final Offset current;
  final bool isSelecting;

  const DiagramSelectionDetails({
    required this.start,
    required this.current,
    required this.isSelecting,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DiagramSelectionDetails &&
        other.start == start &&
        other.current == current &&
        other.isSelecting == isSelecting;
  }

  @override
  int get hashCode => start.hashCode ^ current.hashCode ^ isSelecting.hashCode;
}
