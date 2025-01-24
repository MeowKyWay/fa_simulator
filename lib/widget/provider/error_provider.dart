import 'package:fa_simulator/compiler/diagram_error_checker.dart';
import 'package:fa_simulator/compiler/diagram_error_list.dart';
import 'package:fa_simulator/widget/provider/diagram_provider.dart';
import 'package:flutter/material.dart';

class ErrorProvider extends DiagramProvider with ChangeNotifier {
  static final ErrorProvider _instance = ErrorProvider._internal(); //Singleton
  ErrorProvider._internal();
  factory ErrorProvider() {
    return _instance;
  }

  DiagramErrorList _errorList = DiagramErrorList();

  DiagramErrorList get errorList => _errorList;

  void checkErrors() {
    _errorList.checkError();
    notifyListeners();
  }

  @override
  void reset() {
    _errorList = DiagramErrorList();
    notifyListeners();
  }
}
