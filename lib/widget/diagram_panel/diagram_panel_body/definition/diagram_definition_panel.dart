import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/resource/theme/text_style_extensions.dart';
import 'package:fa_simulator/widget/diagram_panel/diagram_panel_body/definition/panel_transition_function.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class DiagramDefinitionPanel extends StatefulWidget {
  const DiagramDefinitionPanel({super.key});

  @override
  State<DiagramDefinitionPanel> createState() => _DiagramDefinitionPanelState();
}

class _DiagramDefinitionPanelState extends State<DiagramDefinitionPanel>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Consumer<DiagramList>(
      builder: (context, provider, child) {
        if (DiagramList().validator.errors.hasError) {
          return Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Error: There are errors in the diagram.',
              style: Theme.of(context).textTheme.labelMedium?.red(context),
            ),
          );
        }

        return Material(
          color: Colors.transparent,
          textStyle: Theme.of(context).textTheme.labelSmall,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Consumer<DiagramList>(builder: (context, _, __) {
                String statesLabel;
                statesLabel = (DiagramList().states.map((e) => e.label).toList()
                      ..sort())
                    .join(', ');

                String initialState = '';
                String finalStates =
                    (DiagramList().finalStates.map((e) => e.label).toList()
                          ..sort())
                        .join(', ');
                try {
                  initialState = DiagramList().initialStates.first.label;
                } catch (_) {}
                return Column(
                  spacing: 5,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${(DiagramList().type.toString().toUpperCase())} Definition',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Gap(5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Q = '),
                        Flexible(
                          fit: FlexFit.loose,
                          child: Text(
                            '{ $statesLabel }',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Σ = '),
                        Flexible(
                          fit: FlexFit.loose,
                          child: Text(
                            '{ ${DiagramList().alphabet.join(', ')} }',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    PanelTransitionFunction(
                      transitionFunction:
                          DiagramList().compiler.transitionFunction,
                    ),
                    Text('q₀ = $initialState'),
                    Row(
                      children: [
                        Text('F = '),
                        Flexible(child: Text('{ $finalStates }')),
                      ],
                    ),
                  ],
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
