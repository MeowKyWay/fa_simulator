import 'package:flutter/material.dart';

class DiagramIcon extends StatelessWidget {
  const DiagramIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage('assets/images/logo.png'),
      width: 65,
      height: 65,
      
    );
  }
}
