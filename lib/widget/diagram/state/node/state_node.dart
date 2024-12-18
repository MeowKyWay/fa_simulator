import 'dart:developer';

import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/diagram/rename_diagrams_action.dart';
import 'package:fa_simulator/config/theme.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/accept_state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/start_state_type.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/state_type.dart';
import 'package:fa_simulator/widget/diagram/draggable/diagram/diagram_draggable.dart';
import 'package:fa_simulator/widget/diagram/state/node/accept_state.dart';
import 'package:fa_simulator/widget/diagram/state/node/start_state.dart';
import 'package:fa_simulator/widget/diagram/state/node/state.dart';
import 'package:fa_simulator/widget/diagram/draggable/diagram/rename_text_field.dart';
import 'package:fa_simulator/widget/provider/renaming_provider.dart';
import 'package:flutter/material.dart';

class StateNode extends StatefulWidget {
  //TODO when renaming and click other diagram item the rename cancle and result in blank label
  //TODO when shift + char the keyboardProvider does not start the renaming
  final StateType state;
  final bool isRenaming;

  // Diagram State constructor
  const StateNode({
    super.key,
    required this.state,
    required this.isRenaming,
  });

  @override
  State<StateNode> createState() {
    return _StateNodeState();
  }
}

class _StateNodeState extends State<StateNode> {
  //Do not use set state in this class
  final TextEditingController _controller = RenamingProvider().controller;
  late FocusNode _renameFocusNode;
  late VoidCallback _listener;

  @override
  void initState() {
    super.initState();
    _listener = () {
      if (!_renameFocusNode.hasFocus) {
        String newName = _controller.text;
        if (newName != widget.state.label) {
          AppActionDispatcher().execute(RenameDiagramsAction(
            id: widget.state.id,
            name: newName,
          ));
        }
        log("RenamingProvider().reset()");
        RenamingProvider().reset();
      }
    };
    _renameFocusNode = FocusNode();
    _renameFocusNode.addListener(_listener);
  }

  @override
  void dispose() {
    super.dispose();
    _renameFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isRenaming) {
      _renameFocusNode.requestFocus();
    }

    //2 frame after the build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (widget.isRenaming) {
          _controller.selection =
              TextSelection.collapsed(offset: _controller.text.length);
        }
      });
    });

    Widget child = Center(
      // If renaming, show the text field
      child: widget.isRenaming
          ? Padding(
              padding: const EdgeInsets.all(5),
              child: RenameTextField(
                controller: _controller,
                focusNode: _renameFocusNode,
              ),
            )
          : Text(
              widget.state.label,
              style: textXL,
            ),
    );

    return GestureDetector(
      // Just to absorb the tap event
      child: Stack(
        children: [
          DiagramDraggable(
            child: widget.state is AcceptStateType
                ? acceptState(child: child)
                : widget.state is StartStateType
                    ? startState(child: child)
                    : state(child: child),
          ),
        ],
      ),
    );
  }
}
