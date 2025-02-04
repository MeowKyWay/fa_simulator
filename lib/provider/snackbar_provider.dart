import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarProvider extends GetxController {
  final GlobalKey<ScaffoldMessengerState> snackbarKey =
      GlobalKey<ScaffoldMessengerState>();

  void showSnackbar(String message) {
    snackbarKey.currentState?.showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void showError(String message) {
    snackbarKey.currentState?.clearSnackBars(); // Clear current snackbars
    snackbarKey.currentState?.showSnackBar(
      SnackBar(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        duration: Duration(seconds: 3),
        content: Text(
          message,
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
