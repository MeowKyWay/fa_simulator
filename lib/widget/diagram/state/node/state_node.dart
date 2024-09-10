import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/state/rename_state_action.dart';
import 'package:fa_simulator/config/theme.dart';
import 'package:fa_simulator/widget/body/input/body_keyboard_listener.dart';
import 'package:fa_simulator/widget/diagram/draggable/diagram_draggable.dart';
import 'package:fa_simulator/widget/diagram/state/node/state.dart';
import 'package:fa_simulator/widget/diagram/state/state_rename_text_field.dart';
import 'package:fa_simulator/widget/diagram/state_list.dart';
import 'package:flutter/material.dart';

class StateNode extends StatefulWidget {
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
  String newName = '';
  late FocusNode _renameFocusNode;
  late VoidCallback _listener;

  @override
  void initState() {
    super.initState();
    _listener = () {
      if (!_renameFocusNode.hasFocus) {
        AppActionDispatcher()
            .execute(RenameStateAction(widget.state.id, newName));
        KeyboardSingleton().focusNode.requestFocus();
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
      // Request focus for the rename text field
      _renameFocusNode.requestFocus();
    }
    return GestureDetector(
      // Just to absorb the tap event
      child: Stack(
        children: [
          state(
            child: Center(
              // If renaming, show the text field
              child: widget.isRenaming
                  ? Padding(
                      padding: const EdgeInsets.all(5),
                      child: StateRenameTextField(
                        focusNode: _renameFocusNode,
                        stateName: widget.state.name,
                        onChanged: (value) => newName = value,
                        onSubmitted: (value) => _renameFocusNode.unfocus(),
                      ),
                    )
                  : Text(
                      widget.state.name,
                      style: textLarge,
                    ),
            ),
          ),
          const Positioned.fill(
            child: DiagramDraggable(),
          ),
        ],
      ),
    );
  }
}
