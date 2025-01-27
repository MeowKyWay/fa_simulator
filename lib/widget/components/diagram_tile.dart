import 'package:flutter/material.dart';

class DiagramTile extends StatelessWidget {
  final String? leading;
  final String? body;
  final String? trailing;
  final TextStyle? style;

  const DiagramTile({
    super.key,
    this.leading,
    this.body,
    this.trailing,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle? style = this.style ?? Theme.of(context).textTheme.labelMedium;

    return Row(
      spacing: 10,
      children: [
        if (leading != null)
          Text(
            leading!,
            style: style,
          ),
        if (body != null)
          Text(
            body!,
            style: style,
          ),
        if (trailing != null)
          Text(
            trailing!,
            style: style,
          ),
      ],
    );
  }
}
