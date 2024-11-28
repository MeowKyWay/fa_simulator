
import 'package:fa_simulator/config/theme.dart';
import 'package:flutter/material.dart';

class StateRenameTextField extends StatelessWidget {
  //TODO Bug when renaming into 1 character long name
  final FocusNode focusNode;
  final String stateName;
  final Function(String) onChanged;
  final Function(String) onSubmitted;

  const StateRenameTextField({
    super.key,
    required this.focusNode,
    required this.stateName,
    required this.onChanged,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      initialValue: stateName,
      textAlign: TextAlign.center,
      style: textLarge,
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      onChanged: (value) {
        onChanged(value);
      },
      onFieldSubmitted: (value) {
        onSubmitted(value);
      },
    );
  }
}
