import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/state/rename_state_action.dart';
import 'package:fa_simulator/config/theme.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/diagram/diagram_type.dart';
import 'package:fa_simulator/widget/diagram/draggable/diagram_draggable.dart';
import 'package:fa_simulator/widget/diagram/state/hover_overlay/state_hover_overlay.dart';
import 'package:fa_simulator/widget/diagram/state/node/state.dart';
import 'package:fa_simulator/widget/diagram/state/state_rename_text_field.dart';
import 'package:fa_simulator/widget/keyboard/keyboard_singleton.dart';
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
  //Do not use set state in this class
  late FocusNode _renameFocusNode;
  late VoidCallback _listener;

  @override
  void initState() {
    super.initState();
    _listener = () {
      if (!_renameFocusNode.hasFocus) {
        String newName = DiagramList().renamingItemNewName;
        if (newName != widget.state.name) {
          AppActionDispatcher()
              .execute(RenameStateAction(widget.state.id, newName));
        } else {
          DiagramList().endRename();
        }
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
      if (DiagramList().renamingItemInitialName == "") {
        DiagramList().renamingItemNewName =
            DiagramList().renamingItemInitialName;
      }
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
                        stateName: DiagramList().renamingItemInitialName != ""
                            ? DiagramList().renamingItemInitialName
                            : widget.state.name,
                        onChanged: (value) {
                          DiagramList().renamingItemNewName = value;
                        },
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
