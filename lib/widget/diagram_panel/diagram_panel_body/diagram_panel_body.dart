import 'package:fa_simulator/config/config.dart';
import 'package:flutter/material.dart';

class DiagramPanelBody extends StatelessWidget {
  const DiagramPanelBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: bodySize.width,
        decoration: BoxDecoration(
          color: Colors.blue,
          border: Border.all(
            color: Colors.pink,
            width: 10,
          ),
        ),
      ),
    );
  }
}
