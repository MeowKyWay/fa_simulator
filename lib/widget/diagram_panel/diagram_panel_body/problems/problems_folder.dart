import 'package:fa_simulator/provider/diagram_provider/error/diagram_errors.dart';
import 'package:fa_simulator/widget/diagram_panel/diagram_panel_body/problems/problem_item.dart';
import 'package:flutter/material.dart';

class ProblemsFolder<T1, T2 extends DiagramErrors> extends StatefulWidget {
  final Map<T1, T2> errors;
  final String title;
  final int dept;

  const ProblemsFolder({
    super.key,
    required this.errors,
    required this.title,
    required this.dept,
  });

  @override
  State<ProblemsFolder<T1, T2>> createState() => _ProblemsFolderState<T1, T2>();
}

class _ProblemsFolderState<T1, T2 extends DiagramErrors>
    extends State<ProblemsFolder<T1, T2>> {
  bool _isExpanded = true;
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    if (widget.errors.isEmpty) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MouseRegion(
          onEnter: (_) {
            setState(() {
              _isHovering = true;
            });
          },
          onExit: (_) {
            setState(() {
              _isHovering = false;
            });
          },
          child: GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 2.5),
              width: double.infinity,
              color: _isHovering
                  ? Theme.of(context).colorScheme.tertiary.withAlpha(194)
                  : null,
              child: Padding(
                padding: EdgeInsets.only(left: widget.dept * 20),
                child: Row(
                  spacing: 5,
                  children: [
                    Icon(
                      _isExpanded
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_right,
                      size: 18,
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Text(
                        widget.title,
                        style: Theme.of(context).textTheme.labelSmall,
                        overflow: TextOverflow.clip,
                        softWrap: false,
                      ),
                    ),
                    CircleAvatar(
                      radius: 9,
                      backgroundColor: Colors.grey.shade800,
                      child: Text(
                        widget.errors.length.toString(),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        if (_isExpanded)
          for (final errors in widget.errors.entries)
            for (final error in errors.value.errors)
              ProblemItem<T1>(
                error: error,
                item: errors.key,
                dept: widget.dept + 1,
              ),
      ],
    );
  }
}
