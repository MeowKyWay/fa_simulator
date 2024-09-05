import 'package:fa_simulator/widget/body/body_singleton.dart';
import 'package:flutter/material.dart';

class PalleteFeedbackProvider with ChangeNotifier {
  static final PalleteFeedbackProvider _instance =
      PalleteFeedbackProvider._internal();
  PalleteFeedbackProvider._internal();
  factory PalleteFeedbackProvider() {
    return _instance;
  }

  Offset? _position;
  Offset? _previousPosition;
  Offset _margin = Offset.zero;
  Widget? _feedback;

  Offset? get position => _position;
  Widget? get feedback {
    if (_position == null || _feedback == null) return null;
    return Positioned(
      left: _position!.dx,
      top: _position!.dy,
      child: _feedback!,
    );
  }

  set position(Offset? position) {
    _previousPosition = _position;
    if (position == null) {
      _position = null;
      notifyListeners();
      return;
    }
    _position = BodySingleton().getSnappedPosition(
      BodySingleton().getBodyLocalPosition(position) - _margin,
    );
    if (_position == _previousPosition) return;
    notifyListeners();
  }

  set feedback(Widget? feedback) {
    _feedback = feedback;
    notifyListeners();
  }

  set margin(Offset margin) {
    _margin = margin;
  }

  void reset() {
    _position = null;
    _previousPosition = null;
    _feedback = null;
    _margin = Offset.zero;
    notifyListeners();
  }
}
