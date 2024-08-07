import 'package:fa_simulator/widget/app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: Scaffold(
      body: DefaultTextStyle(
        style: TextStyle(
          color: Colors.black,
          decoration: TextDecoration.none,
          fontSize: 20,
        ),
        child: App(),
      ),
    ));
  }
}
