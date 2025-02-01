import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:flutter/material.dart';

class AlphabetTextField extends StatefulWidget {
  final TextStyle? style;
  final Function(String)? onSubmitted;
  final FocusNode focusNode;

  const AlphabetTextField({
    super.key,
    required this.style,
    required this.onSubmitted,
    required this.focusNode,
  });

  @override
  State<AlphabetTextField> createState() => _AlphabetTextFieldState();
}

class _AlphabetTextFieldState extends State<AlphabetTextField> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: IntrinsicWidth(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 650,
          ),
          child: TextFormField(
            focusNode: widget.focusNode,
            autofocus: true,
            minLines: 1,
            maxLines: 3,
            textInputAction: TextInputAction.done,
            style: widget.style,
            initialValue: DiagramList().alphabet.join(', '),
            decoration: InputDecoration.collapsed(
              hintText: 'Enter alphabet',
              hintStyle: widget.style,
            ),
            onFieldSubmitted: widget.onSubmitted,
          ),
        ),
      ),
    );
  }
}
