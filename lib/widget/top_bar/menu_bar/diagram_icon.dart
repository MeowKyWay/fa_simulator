import 'package:flutter/material.dart';

class DiagramIcon extends StatelessWidget {
  const DiagramIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Image(
        image: AssetImage('assets/icon/icon_1024.png'),
        width: 65,
        height: 65,
      ),
    );
  }
}
