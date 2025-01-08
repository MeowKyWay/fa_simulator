import 'package:fa_simulator/action/app_action.dart';
import 'package:fa_simulator/config/theme.dart';
import 'package:flutter/material.dart';

abstract class DiagramMenu extends StatefulWidget {
  const DiagramMenu({
    super.key,
  });

  String get label;

  List<PopupMenuEntry<AppAction?>> get items;

  @override
  State<DiagramMenu> createState() => _DiagramMenuState();
}

class _DiagramMenuState extends State<DiagramMenu> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {

    ThemeData theme = Theme.of(context);

    return MouseRegion(
      onEnter: (event) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHovered = false;
        });
      },
      child: PopupMenuButton<AppAction?>(
        tooltip: "",
        color: theme.colorScheme.primary,
        menuPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(
            color: theme.colorScheme.outlineVariant,
            width: 1,
          ),
        ),
        offset: const Offset(0, 30),
        itemBuilder: (context) {
          return widget.items;
        },
        onSelected: (action) {
          action?.execute();
        },
        child: Container(
          color: isHovered ? theme.colorScheme.surface : theme.colorScheme.primary,
          height: double.infinity,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.label,
                style: textM.copyWith(
                  color: secondaryTextColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void render() {
    setState(() {});
  }
}
