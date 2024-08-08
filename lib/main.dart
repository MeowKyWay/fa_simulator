import 'package:fa_simulator/config.dart';
import 'package:fa_simulator/state_list.dart';
import 'package:fa_simulator/widget/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StateList(),
      child: const MaterialApp(
          home: Scaffold(
        body: DefaultTextStyle(
          style: TextStyle(
            color: textColor,
            decoration: textDecoration,
            fontSize: 20,
          ),
          child: App(),
        ),
      )),
    );
  }
}
