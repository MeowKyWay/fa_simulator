import 'package:fa_simulator/widget/provider/body_provider.dart';
import 'package:fa_simulator/widget/provider/diagram_provider.dart';
import 'package:flutter/material.dart';

class PalleteFeedbackProvider extends DiagramProvider with ChangeNotifier {
  static final PalleteFeedbackProvider _instance =
      PalleteFeedbackProvider._internal();
  PalleteFeedbackProvider._internal();
  factory PalleteFeedbackProvider() {
    return _instance;
  }

  Offset? _position;
  Offset? _previousPosition;
  Offset margin = Offset.zero;
  Widget? _feedback;

  bool _withinBody = false;

  Offset? get position => _position;
  Widget? get feedback {
    if (_position == null || _feedback == null) return null;
    return Positioned(
      left: _position!.dx,
      top: _position!.dy,
      child: IgnorePointer(child: _feedback!),
    );
  }
  bool get withinBody => _withinBody;

  set position(Offset? position) {
    _previousPosition = _position;
    if (position == null) {
      _position = null;
      notifyListeners();
      return;
    }
    _position = BodyProvider().getSnappedPosition(
      BodyProvider().getBodyLocalPosition(position) - margin,
    );
    if (_position == _previousPosition) return;
    notifyListeners();
  }

  set feedback(Widget? feedback) {
    _feedback = feedback;
    notifyListeners();
  }

  set withinBody(bool withinBody) {
    _withinBody = withinBody;
    notifyListeners();
  }

  @override
  void reset() {
    _position = null;
    _previousPosition = null;
    _feedback = null;
    margin = Offset.zero;
    _withinBody = false;
    notifyListeners();
  }
}
