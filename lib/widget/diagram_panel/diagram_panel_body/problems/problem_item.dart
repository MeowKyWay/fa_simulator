import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/focus/focus_action.dart';
import 'package:fa_simulator/provider/diagram_provider/error/diagram_error_enums.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class ProblemItem<T> extends StatefulWidget {
  final ErrorType error;
  final T item;
  final int dept;

  const ProblemItem({
    super.key,
    required this.error,
    required this.item,
    required this.dept,
  });

  @override
  State<ProblemItem> createState() => _ProblemItemState();
}

class _ProblemItemState extends State<ProblemItem> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
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
          if (widget.item is String) {
            AppActionDispatcher().execute(FocusAction([widget.item]));
            return;
          }
          if (widget.item is Tuple2<String, String>) {
            AppActionDispatcher().execute(FocusAction([widget.item.item1]));
            return;
          }
        },
        child: Container(
          color: _isHovering
              ? Theme.of(context).colorScheme.tertiary.withAlpha(128)
              : null,
          child: Padding(
            padding: EdgeInsets.fromLTRB(widget.dept * 20, 2.5, 0, 2.5),
            child: Row(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.error_outline,
                  color: Theme.of(context).colorScheme.error,
                  size: 18,
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Text(
                    widget.error.detail(widget.item),
                    style: Theme.of(context).textTheme.labelSmall,
                    softWrap: false,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
