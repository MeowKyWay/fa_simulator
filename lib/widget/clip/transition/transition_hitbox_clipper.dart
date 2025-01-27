import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_path.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_type.dart';
import 'package:flutter/material.dart';

class TransitionHitboxClipper extends CustomClipper<Path> {
  final TransitionType transition;
  final double width;

  TransitionHitboxClipper({
    required this.transition,
    this.width = 10,
  });

  @override
  Path getClip(Size size) {
    return transition.getHitBox(width/2);
  }

  @override
  bool shouldReclip(covariant TransitionHitboxClipper oldClipper) {
    return oldClipper.transition != transition;
  }
}