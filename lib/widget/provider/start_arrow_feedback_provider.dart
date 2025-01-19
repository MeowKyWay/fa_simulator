import 'package:fa_simulator/widget/provider/diagram_provider.dart';
import 'package:flutter/material.dart';

class StartArrowFeedbackProvider extends DiagramProvider with ChangeNotifier {
  static final StartArrowFeedbackProvider _instance =
      StartArrowFeedbackProvider._internal(); //Singleton
  StartArrowFeedbackProvider._internal();
  factory StartArrowFeedbackProvider() => _instance;

  String? _id;
  double? _angle;

  String? get id => _id;
  double? get angle => _angle;

  set id(String? id) {
    _id = id;
    notifyListeners();
  }

  set angle(double? angle) {
    _angle = angle;
    notifyListeners();
  }

  @override
  void reset() {
    _id = null;
    _angle = null;
    notifyListeners();
  }
}