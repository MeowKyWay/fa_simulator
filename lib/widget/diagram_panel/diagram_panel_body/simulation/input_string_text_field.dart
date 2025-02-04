import 'package:fa_simulator/widget/components/button.dart';
import 'package:flutter/material.dart';

class InputStringTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function() onSubmitted;
  final Function() onChanged;
  final Function() onClear;

  const InputStringTextField({
    super.key,
    required this.controller,
    required this.onSubmitted,
    required this.onChanged,
    required this.onClear,
  });

  // String? _validator(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Please enter the input string';
  //   }
  //   List<String> input = value.split(',');
  //   List<String> alphabet = DiagramList().alphabet;
  //   for (String symbol in input) {
  //     if (!alphabet.contains(symbol)) {
  //       return 'The symbol $symbol is not in the alphabet';
  //     }
  //   }
  //   return '';
  // }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('Input String: ', style: Theme.of(context).textTheme.labelSmall),
        Flexible(
          flex: 1,
          fit: FlexFit.loose,
          child: IntrinsicWidth(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                spacing: 5,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.5),
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    child: TextFormField(
                      controller: controller,
                      // validator: _validator,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Enter the input string (comma separated)',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(
                                color:
                                    Theme.of(context).colorScheme.onSecondary),
                      ),
                      minLines: 1,
                      maxLines: 50,
                      style: Theme.of(context).textTheme.labelSmall,
                      onFieldSubmitted: (_) => onSubmitted(),
                      onChanged: (_) => onChanged(),
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: 5,
                    children: [
                      Button(
                        text: 'Clear',
                        style: ButtonVariant.contained,
                        textStyle: Theme.of(context).textTheme.labelSmall,
                        onPressed: onClear,
                      ),
                      Button(
                        text: 'Run',
                        style: ButtonVariant.contained,
                        textStyle: Theme.of(context).textTheme.labelSmall,
                        onPressed: onSubmitted,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
