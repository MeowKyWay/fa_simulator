import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
import 'package:fa_simulator/provider/diagram_provider/error/diagram_error_enums.dart';
import 'package:fa_simulator/provider/diagram_provider/error/diagram_error_list.dart';
import 'package:fa_simulator/provider/diagram_provider/error/diagram_errors.dart';
import 'package:fa_simulator/widget/diagram_panel/diagram_panel_body/problems/problem_item.dart';
import 'package:fa_simulator/widget/diagram_panel/diagram_panel_body/problems/problems_folder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class DiagramProblemsPanel extends StatefulWidget {
  const DiagramProblemsPanel({
    super.key,
  });

  @override
  State<DiagramProblemsPanel> createState() => _DiagramProblemsPanelState();
}

class _DiagramProblemsPanelState extends State<DiagramProblemsPanel>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<DiagramList>(builder: (context, provider, child) {
      final DiagramErrorList errors = DiagramList().validator.errors;

      DiagramErrors<ErrorType> diagramErrors =
          errors[DiagramErrorClassType.diagramError];
      Map<String, StateErrors> stateErrors =
          errors[DiagramErrorClassType.stateError];
      Map<String, TransitionErrors> transitionErrors =
          errors[DiagramErrorClassType.transitionError];
      Map<String, SymbolErrors> symbolErrors =
          errors[DiagramErrorClassType.symbolError];
      Map<Tuple2<String, String>, TransitionFunctionErrors>
          transitionFunctionErrors =
          errors[DiagramErrorClassType.transitionFunctionError];
      Map<Tuple2<String, String>, TransitionFunctionEntryErrors>
          transitionFunctionEntryErrors =
          errors[DiagramErrorClassType.transitionFunctionEntryError];

      return SingleChildScrollView(
        child: Theme(
          data: Theme.of(context).copyWith(
            textTheme: Theme.of(context).textTheme.copyWith(
                  labelSmall: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!errors.hasError)
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'No problems have been detected in the diagram.',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
              for (final error in diagramErrors.errors)
                ProblemItem<Null>(error: error, item: null, dept: 1),
              ProblemsFolder(
                errors: stateErrors,
                title: 'State Problem.',
                dept: 1,
              ),
              ProblemsFolder(
                errors: transitionErrors,
                title: 'Transition Problem.',
                dept: 1,
              ),
              ProblemsFolder(
                errors: symbolErrors,
                title: 'Symbol Problem.',
                dept: 1,
              ),
              ProblemsFolder(
                errors: transitionFunctionErrors,
                title: 'Transition Function Problem.',
                dept: 1,
              ),
              ProblemsFolder(
                errors: transitionFunctionEntryErrors,
                title: 'Transition Function Entry Problem.',
                dept: 1,
              ),
            ],
          ),
        ),
      );
    });
  }
}
