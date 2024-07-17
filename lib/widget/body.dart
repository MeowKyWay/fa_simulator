import 'dart:developer';

import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
          onTapDown: (TapDownDetails details) {
            log('Tap position: ${details.localPosition}');
          },
          child: Container(
            color: Colors.grey[200],
            width: double.infinity,
            height: double.infinity,
            child: const Center(
              child: Text('Tap anywhere'),
            ),
          ),
      ),
    );
  }
}