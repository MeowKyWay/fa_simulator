import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:flutter/material.dart';

class AlphabetRow extends StatelessWidget {
  const AlphabetRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Alphabet', style: Theme.of(context).textTheme.labelMedium),
        Text(DiagramList().alphabet.join(', '),
            style: Theme.of(context).textTheme.labelMedium),
        Text(
          DiagramList().unregisteredAlphabet.join(', '),
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
        ),
      ],
    );
  }
}
