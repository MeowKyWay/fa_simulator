// import 'package:fa_simulator/action/app_action_dispatcher.dart';
// import 'package:fa_simulator/action/transition/attach_transitions_action.dart';
// import 'package:fa_simulator/action/transition/create_transition_action.dart';
// import 'package:fa_simulator/widget/body/component/body_drag_target.dart';
// import 'package:fa_simulator/widget/diagram/diagram_type.dart';
// import 'package:fa_simulator/widget/diagram/draggable/new_transition/new_transition_draggable.dart';
// import 'package:fa_simulator/widget/provider/new_transition_provider.dart';
// import 'package:flutter/material.dart';

// class StateHoverOverlayDragTarget extends StatelessWidget {
//   final Widget child;
//   final StateType state;

//   const StateHoverOverlayDragTarget({
//     super.key,
//     required this.state,
//     required this.child,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return DragTarget(
//       onWillAcceptWithDetails: (DragTargetDetails details) {
//         if (details.data is NewTransitionType) {
//           return _onWillAcceptNewTransitionWithDetails(
//               details.data as NewTransitionType);
//         }
//         if (details.data is DraggingTransitionType) {
//           return _onWillAcceptDraggingTransition(
//               details.data as DraggingTransitionType);
//         }
//         return false;
//       },
//       onAcceptWithDetails: (details) {
//         if (details.data is NewTransitionType) {
//           _onAcceptNewTransitionWithDetails(details.data as NewTransitionType);
//         }
//         if (details.data is DraggingTransitionType) {
//           _onAcceptDraggingTransition(details.data as DraggingTransitionType);
//         }
//       },
//       onLeave: (details) {},
//       hitTestBehavior: HitTestBehavior.translucent,
//       builder: (context, candidateData, rejectedData) => child,
//     );
//   }

//   bool _onWillAcceptNewTransitionWithDetails(NewTransitionType data) {
//     if (data.from.id == state.id) {
//       return false;
//     }
//     return true;
//   }

//   bool _onWillAcceptDraggingTransition(DraggingTransitionType data) {
//     if (data.draggingPivot == TransitionPivotType.center) {
//       return false;
//     }
//     return true;
//   }

//   void _onAcceptNewTransitionWithDetails(NewTransitionType data) {
//     StateType sourceState = data.from;

//     AppActionDispatcher().execute(
//       CreateTransitionAction(
//         sourceStateId: sourceState.id,
//         destinationStateId: state.id,
//         sourceStateCentered: NewTransitionProvider().sourceStateCentered,
//         sourceStateAngle: NewTransitionProvider().sourceStateAngle,
//         destinationStateCentered: false,
//         destinationStateAngle: NewTransitionProvider().destinationStateAngle,
//       ),
//     );
//   }

//   void _onAcceptDraggingTransition(DraggingTransitionType data) {
//     AppActionDispatcher().execute(AttachTransitionAction(
//       id: data.transition.id,
//       endPoint: data.draggingPivot == TransitionPivotType.start
//           ? TransitionEndPointType.start
//           : TransitionEndPointType.end,
//       stateId: state.id,
//     ));
//   }
// }
