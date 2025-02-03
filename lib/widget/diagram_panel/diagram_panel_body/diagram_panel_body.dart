import 'package:flutter/material.dart';

class DiagramPanelBody extends StatelessWidget {
  final PageController controller;

  const DiagramPanelBody({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView(
        controller: controller,
        children: [
          Container(
            color: Colors.red,
          ),
          Container(
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
