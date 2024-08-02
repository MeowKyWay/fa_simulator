import 'dart:developer';

import 'package:fa_simulator/widget/diagram/diagram_state.dart';
import 'package:flutter/material.dart';
import '../diagram_state_counter.dart' as globals;

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() {
    return _BodyState();
  }
}

class _BodyState extends State<Body> {
  final List<DiagramState> _states = [];
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.requestFocus();
  }

  void _removeState(String name) {
    setState(() {
      _states.removeWhere((element) => element.name == name);
      FocusScope.of(context).unfocus();
    });
  }

  void _addState(Offset position) {
    setState(() {
      DiagramState state = DiagramState(
        position: position,
        name: globals.stateCounter.toString(),
        onRemove: _removeState,
      );
      _states.add(state);
      globals.stateCounter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Focus(
        child: Stack(
          children: [
            GestureDetector(
              onTapDown: (TapDownDetails details) {
                setState(() {
                  _addState(details.localPosition);
                });
              },
            ),
            ..._states,
          ],
        ),
      ),
    );
  }
}
