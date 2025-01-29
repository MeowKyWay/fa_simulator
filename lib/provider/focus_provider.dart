import 'package:flutter/material.dart';

class FocusNotifier extends ChangeNotifier {
  final Set<String> _focusItemIds = {};

  /// Add focus to the item with the provided id
  void addFocus(String id) {
    _focusItemIds.add(id);
    notifyListeners();
  }

  /// Add focus to each item with the provided ids
  void addFocusAll(Iterable<String> ids) {
    _focusItemIds.addAll(ids);
    notifyListeners();
  }

  /// Remove focus from the item with the provided id
  void removeFocus(String id) {
    _focusItemIds.remove(id);
    notifyListeners();
  }

  /// Remove focus from each item with the provided ids
  void removeFocusAll(Iterable<String> ids) {
    _focusItemIds.removeAll(ids);
    notifyListeners();
  }

  /// Remove focus from all items
  void clearFocus() {
    _focusItemIds.clear();
    notifyListeners();
  }

  /// Request focus for the item with the provided id
  /// This will remove focus from all other items
  void requestFocus(String id) {
    _focusItemIds.clear();
    _focusItemIds.add(id);
    notifyListeners();
  }

  /// Request focus for each item with the provided ids
  /// This will remove focus from all other items
  void requestFocusAll(Iterable<String> ids) {
    _focusItemIds.clear();
    _focusItemIds.addAll(ids);
    notifyListeners();
  }

  /// Toggle focus for the item with the provided id
  void toggleFocus(String id) {
    if (_focusItemIds.contains(id)) {
      _focusItemIds.remove(id);
    } else {
      _focusItemIds.add(id);
    }
    notifyListeners();
  }

  /// Unfocus all
  void unfocus() {
    _focusItemIds.clear();
    notifyListeners();
  }

  /// Return true if the item with the provided id is focused
  bool hasFocus(String id) {
    return _focusItemIds.contains(id);
  }

  /// Return every focused item id
  Set<String> get focusItemIds {
    return Set<String>.from(_focusItemIds);
  }
}

class FocusProvider extends InheritedNotifier<FocusNotifier> {
  const FocusProvider({
    super.key,
    required super.notifier,
    required super.child,
  });

  static FocusNotifier of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<FocusProvider>()!
        .notifier!;
  }
}
