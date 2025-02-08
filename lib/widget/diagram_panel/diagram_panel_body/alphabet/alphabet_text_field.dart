import 'package:flutter/material.dart';

class AlphabetTextField extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final Function(String) onSubmitted;

  const AlphabetTextField({
    super.key,
    required this.focusNode,
    required this.controller,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration.collapsed(
          hintText: 'Enter the alphabet',
        ),
        style: Theme.of(context).textTheme.labelSmall,
        onSubmitted: onSubmitted,
        textInputAction: TextInputAction.done,
        maxLines: 10,
        minLines: 1,
      ),
    );
  }
}
