import 'package:fa_simulator/theme/text_style_extensions.dart';
import 'package:fa_simulator/widget/components/button.dart';
import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list.dart';
import 'package:fa_simulator/widget/overlay/confirm_overlay.dart';
import 'package:flutter/material.dart';

class AlphabetRow extends StatefulWidget {
  final List<String> alphabet;
  final List<String> unregisteredAlphabet;

  const AlphabetRow({
    super.key,
    required this.alphabet,
    required this.unregisteredAlphabet,
  });

  @override
  State<AlphabetRow> createState() => _AlphabetRowState();
}

class _AlphabetRowState extends State<AlphabetRow> {
  @override
  Widget build(BuildContext context) {
    TextStyle? style = Theme.of(context).textTheme.labelMedium;

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
                style: style,
              ),
            ),
            Text(
              ": Σ = { ",
              style: style,
            ),
            Expanded(
              child: RichText(
                softWrap: true,
                text: TextSpan(
                  style: style,
                  children: [
                    TextSpan(
                      text: widget.alphabet.join(', '),
                    ),
                    if (widget.alphabet.isNotEmpty &&
                        widget.unregisteredAlphabet.isNotEmpty)
                      TextSpan(
                        text: ', ',
                      ),
                    TextSpan(
                      text: widget.unregisteredAlphabet.join(', '),
                      style: style?.red(context),
                    ),
                    TextSpan(
                      text: widget.alphabet.isEmpty &&
                              widget.unregisteredAlphabet.isEmpty
                          ? "}"
                          : " }",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (widget.unregisteredAlphabet.isNotEmpty)
          Row(
            children: [
              Text(
                "{ ${widget.unregisteredAlphabet.join(', ')} }",
                style: style?.red(context),
                softWrap: true,
              ),
              Text(
                " are not in the alphabet but are present in the diagram.",
                style: style,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Button(
                  text: 'Add',
                  onPressed: () {
                    setState(() {
                      DiagramList()
                          .addAllAlphabet(DiagramList().unregisteredAlphabet);
                    });
                  },
                  style: ButtonVariant.contained,
                  textStyle: style,
                  width: 50,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Button(
                  text: 'Remove',
                  onPressed: () async {
                    if (!await confirm(
                      "This action will remove every symbol in the list from all transitions.",
                      context,
                    )) {
                      return;
                    }
                    setState(() {
                      DiagramList().removeUnregisteredAlphabet();
                    });
                  },
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
