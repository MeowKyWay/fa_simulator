import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/diagram/rename_diagrams_action.dart';
import 'package:fa_simulator/action/focus/focus_action.dart';
import 'package:fa_simulator/config/theme.dart';
import 'package:fa_simulator/provider/focus_provider.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_type.dart';
import 'package:fa_simulator/widget/diagram/draggable/diagram/rename_text_field.dart';
import 'package:fa_simulator/widget/provider/renaming_provider.dart';
import 'package:flutter/material.dart';

class TransitionLabel extends StatefulWidget {
  final TransitionType transition;
  final bool isRenaming;

  const TransitionLabel({
    super.key,
    required this.transition,
    this.isRenaming = false,
  });

  @override
  State<TransitionLabel> createState() => _TransitionLabelState();
}

class _TransitionLabelState extends State<TransitionLabel> {
  final GlobalKey _key = GlobalKey();
  final TextEditingController _controller = RenamingProvider().controller;

  late FocusNode _renameFocusNode;
  late VoidCallback _listener;

  final double _textWidth = 100;
  final double _textHeight = 100;

  @override
  Widget build(BuildContext context) {
    if (widget.isRenaming) {
      _renameFocusNode.requestFocus();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.selection =
            TextSelection.collapsed(offset: _controller.text.length);
      });
    });
    return Positioned(
      left: widget.transition.centerPosition.dx - _textWidth / 2,
      top: widget.transition.centerPosition.dy - _textHeight / 2,
      child: GestureDetector(
        onDoubleTap: () {
          RenamingProvider().startRename(id: widget.transition.id);
        },
        child: Listener(
          onPointerDown: (event) {
            if (!FocusProvider().hasFocus(widget.transition.id)) {
              AppActionDispatcher()
                  .execute(FocusAction([widget.transition.id]));
            }
          },
          child: SizedBox(
            height: _textHeight,
            width: _textWidth,
            child: Center(
              child: Container(
                key: _key,
                color: Theme.of(context).colorScheme.surface,
                child: widget.isRenaming
                    ? RenameTextField(
                        focusNode: _renameFocusNode,
                        controller: _controller,
                        textStyle: textS,
                      )
                    : Text(
                        widget.transition.label,
                        style: textS,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _listener = () {
      if (!_renameFocusNode.hasFocus) {
        String newName = _controller.text;
        if (newName != widget.transition.label) {
          AppActionDispatcher().execute(RenameDiagramsAction(
            id: widget.transition.id,
            name: newName,
          ));
        }
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
}
