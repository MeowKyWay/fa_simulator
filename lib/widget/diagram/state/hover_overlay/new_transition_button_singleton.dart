class NewTransitionButtonSingleton {
  static final NewTransitionButtonSingleton _instance = NewTransitionButtonSingleton._internal();

  factory NewTransitionButtonSingleton() {
    return _instance;
  }

  NewTransitionButtonSingleton._internal();

  bool isHovering = false;
}