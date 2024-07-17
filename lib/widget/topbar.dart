import 'package:flutter/material.dart';

class Topbar extends StatelessWidget {
  const Topbar({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(31, 31, 31, 1),
      height: 35,
      width: double.infinity,
      child: const Column(
        children: [
          Text("Topbar"),
        ],
      ),
    );
  }
}
