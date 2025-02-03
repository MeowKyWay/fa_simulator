import 'package:fa_simulator/widget/components/button.dart';
import 'package:flutter/material.dart';

class InputStringTextField extends StatelessWidget {
  final TextEditingController controller;

  const InputStringTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
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
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.5),
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                      child: TextFormField(
                        controller: controller,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Enter the input string (comma separated)',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondary),
                        ),
                        minLines: 1,
                        maxLines: 50,
                        style: Theme.of(context).textTheme.labelSmall,
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
                        ),
                        Button(
                          text: 'Run',
                          style: ButtonVariant.contained,
                          textStyle: Theme.of(context).textTheme.labelSmall,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
