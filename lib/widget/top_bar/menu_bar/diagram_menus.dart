import 'package:fa_simulator/widget/top_bar/menu_bar/menu/diagram_diagram_menu.dart';
import 'package:fa_simulator/widget/top_bar/menu_bar/menu/diagram_edit_menu.dart';
import 'package:fa_simulator/widget/top_bar/menu_bar/menu/diagram_file_menu.dart';
import 'package:fa_simulator/widget/top_bar/menu_bar/unsave_progress_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DiagramMenus extends StatefulWidget {
  const DiagramMenus({
    super.key,
  });

  @override
  State<DiagramMenus> createState() => _DiagramMenusState();
}

class _DiagramMenusState extends State<DiagramMenus> {
  bool _isOpen = false;

  void _close() {
    setState(() {
      _isOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Listener(
        onPointerDown: (_) {
          if (_isOpen) return;
          setState(() {
            _isOpen = !_isOpen;
          });
        },
        child: Row(
          children: [
            DiagramFileMenu(
              isOpen: _isOpen,
              close: _close,
            ),
            DiagramEditMenu(
              isOpen: _isOpen,
              close: _close,
            ),
            DiagramDiagramMenu(
              isOpen: _isOpen,
              close: _close,
            ),
            Gap(5),
            Padding(
              padding: const EdgeInsets.all(2.5),
              child: UnsaveProgressButton(),
            ),
          ],
        ),
      ),
    );
  }
}
