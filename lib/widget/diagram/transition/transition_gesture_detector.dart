import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/focus/add_focus_action.dart';
import 'package:fa_simulator/action/focus/focus_action.dart';
import 'package:fa_simulator/action/focus/toggle_focus_action.dart';
import 'package:fa_simulator/widget/body/inherited_widget/keyboard/keyboard_data.dart';
import 'package:fa_simulator/widget/clip/transition/transition_hitbox_clipper.dart';
import 'package:fa_simulator/widget/diagram/diagram_type/transition/transition_type.dart';
import 'package:fa_simulator/widget/diagram/draggable/diagram/diagram_draggable.dart';
import 'package:fa_simulator/widget/context_menu/diagram_context_menu_region.dart';
import 'package:fa_simulator/widget/provider/renaming_provider.dart';
import 'package:flutter/material.dart';

class TransitionGestureDetector extends StatefulWidget {
  final TransitionType transition;

  const TransitionGestureDetector({
    super.key,
    required this.transition,
  });

  @override
  State<TransitionGestureDetector> createState() =>
      _TransitionGestureDetectorState();
}

class _TransitionGestureDetectorState extends State<TransitionGestureDetector> {
  final bool _showTransitionHitBox = false;

  final double transitionHitBoxWidth = 10;

  Offset _pointerDownPosition = Offset.zero;
  bool _pointerDownFlag = false;

  @override
  Widget build(BuildContext context) {
    Offset tl = topLeft;
    Offset br = bottomRight;

    return Positioned(
      top: tl.dy,
      left: tl.dx,
      child: ClipPath(
        clipper: TransitionHitboxClipper(
          transition: widget.transition,
          width: 10,
        ),
        child: DiagramDraggable(
          child: DiagramContextMenuRegion(
            child: GestureDetector(
              onDoubleTap: _handleDoubleTap,
              child: Listener(
                onPointerDown: (event) {
                  _pointerDownPosition = event.localPosition;
                  if (!widget.transition.hasFocus) {
                    // Prevent group dragging to only focus the state when drag start
                    _handleClick();
                    _pointerDownFlag = true;
                  }
                },
                onPointerUp: (event) {
                  if (_pointerDownFlag) {
                    _pointerDownFlag = false;
                    return;
                  }
                  if ((_pointerDownPosition - event.localPosition).distance <
                      5) {
                    // If the pointer moved less than 5 pixels, focus the state
                    _handleClick();
                    _focus();
                  }
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.precise,
                  onEnter: (event) {},
                  child: Container(
                    width: (br.dx - tl.dx).abs(),
                    height: (br.dy - tl.dy).abs(),
                    color: _showTransitionHitBox
                        ? Colors.white.withAlpha((255 * 0.5).ceil())
                        : Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Focus the state
  void _handleClick() {
    // If multiple select key is pressed, add state to the focus list
    if (KeyboardData.of(context)!.isShiftPressed) {
      AppActionDispatcher().execute(AddFocusAction(
        [widget.transition.id],
      ));
      return;
    }
    // Else request focus for the state
    AppActionDispatcher().execute(FocusAction(
      [widget.transition.id],
    ));
  }

  void _focus() {
    if (KeyboardData.of(context)!.isShiftPressed) {
      AppActionDispatcher().execute(ToggleFocusAction([widget.transition.id]));
      return;
    }
  }

  void _handleDoubleTap() {
    AppActionDispatcher().execute(FocusAction(
      [widget.transition.id],
    ));
    RenamingProvider().startRename(id: widget.transition.id);
  }

  Offset get topLeft {
    return Offset(widget.transition.left, widget.transition.top) -
        Offset(transitionHitBoxWidth / 2, transitionHitBoxWidth / 2);
  }

  Offset get bottomRight {
    return Offset(widget.transition.right, widget.transition.bottom) +
        Offset(transitionHitBoxWidth / 2, transitionHitBoxWidth / 2);
  }
}
