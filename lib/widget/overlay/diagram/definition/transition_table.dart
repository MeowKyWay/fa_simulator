import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:flutter/material.dart';

class TransitionTable extends StatelessWidget {
  const TransitionTable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    List<StateType> states = DiagramList().states;

    return Container();
  }
}