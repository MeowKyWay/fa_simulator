import 'package:fa_simulator/widget/components/button.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:flutter/material.dart';

class AlphabetRow extends StatelessWidget {
  const AlphabetRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 26,
              width: 75,
              child: Text(
                'Alphabet',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            Text(
              ": Σ = { ",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Expanded(
              child: RichText(
                softWrap: true,
                text: TextSpan(
                  style: Theme.of(context).textTheme.labelMedium,
                  children: [
                    TextSpan(
                      text: DiagramList().alphabet.join(', '),
                    ),
                    TextSpan(
                      text: DiagramList().unregisteredAlphabet.join(', '),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    TextSpan(
                      text: DiagramList().alphabet.isEmpty &&
                              DiagramList().unregisteredAlphabet.isEmpty
                          ? "}"
                          : " }",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (DiagramList().unregisteredAlphabet.isNotEmpty)
          Row(
            children: [
              Text(
                "{ ${DiagramList().unregisteredAlphabet.join(', ')} }",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                softWrap: true,
              ),
              Text(
                " are not in the alphabet. ",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Button(
                  text: 'Add',
                  onPressed: () {},
                  style: ButtonVariant.contained,
                  textStyle: Theme.of(context).textTheme.labelSmall,
                  width: 50,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Button(
                  text: 'Remove',
                  onPressed: () {},
                  style: ButtonVariant.contained,
                  type: ButtonType.warning,
                  textStyle: Theme.of(context).textTheme.labelSmall,
                  width: 50,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
