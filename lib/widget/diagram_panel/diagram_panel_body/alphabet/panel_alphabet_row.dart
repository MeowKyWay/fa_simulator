import 'dart:developer';

import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/symbol/update_alphabet_action.dart';
import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/widget/components/button.dart';
import 'package:fa_simulator/widget/diagram_panel/diagram_panel_body/alphabet/alphabet_text_field.dart';
import 'package:flutter/material.dart';

class PanelAlphabetRow extends StatefulWidget {
  const PanelAlphabetRow({
    super.key,
  });

  @override
  State<PanelAlphabetRow> createState() => _PanelAlphabetRowState();
}

class _PanelAlphabetRowState extends State<PanelAlphabetRow> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Alphabet: ',
        ),
        Flexible(
          fit: FlexFit.loose,
          child: Flex(
            crossAxisAlignment: CrossAxisAlignment.start,
            direction: Axis.horizontal,
            mainAxisSize: MainAxisSize.min,
            children: [
              _isEditing
                  ? Flexible(
                      fit: FlexFit.loose,
                      child: AlphabetTextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        onSubmitted: _onSubmitted,
                      ),
                    )
                  : Flexible(
                      fit: FlexFit.loose,
                      child: Text('{ ${DiagramList().alphabet.join(', ')} }'),
                    ),
              SizedBox(width: 5),
              Button(
                text: _isEditing ? 'Confirm' : 'Edit',
                style: ButtonVariant.contained,
                padding: EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 0,
                ),
                textStyle: Theme.of(context).textTheme.labelSmall,
                onPressed: () {
                  if (!_isEditing) {
                    _controller.clear();
                    _controller.text = DiagramList().alphabet.join(', ');
                    _focusNode.requestFocus();
                    setState(() {
                      _isEditing = !_isEditing;
                    });
                  } else {
                    _onSubmitted(_controller.text);
                  }
                },
              ),
              SizedBox(width: 5),
              if (_isEditing)
                Button(
                  text: 'Cancle',
                  style: ButtonVariant.contained,
                  padding: EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 0,
                  ),
                  textStyle: Theme.of(context).textTheme.labelSmall,
                  onPressed: () {
                    setState(() {
                      _isEditing = !_isEditing;
                    });
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }

  void _onSubmitted(String value) {
    setState(() {
      _isEditing = false;
    });
    AppActionDispatcher().execute(
      UpdateAlphabetAction(symbols: value.split(',')),
    );
    log('PanelAlphabetRow: onSubmitted: $value');
  }
}
