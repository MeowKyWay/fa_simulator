import 'dart:developer';

import 'package:flutter/material.dart';

class DraggableState extends StatefulWidget {
  const DraggableState({
    super.key,
  });

  @override
  State<DraggableState> createState() {
    return _DraggableStateState();
  }
}

class _DraggableStateState extends State<DraggableState> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Draggable(
      feedback: Container(),
      onDragStarted: () {
        log("Drag started");
      },
      child: Container(
        color: Colors.transparent,
      ),
    );
  }
}
