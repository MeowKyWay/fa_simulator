import 'package:fa_simulator/action/app_action_dispatcher.dart';
import 'package:fa_simulator/action/file/compile_diagram_action.dart';
import 'package:fa_simulator/widget/top_bar/menu_bar/menu/diagram_edit_menu.dart';
import 'package:fa_simulator/widget/top_bar/menu_bar/menu/diagram_file_menu.dart';
import 'package:fa_simulator/widget/top_bar/menu_bar/unsave_progress_button.dart';
import 'package:flutter/material.dart';

class DiagramMenus extends StatefulWidget {
  const DiagramMenus({
    super.key,
  });

  @override
  State<DiagramMenus> createState() => _DiagramMenusState();
}

class _DiagramMenusState extends State<DiagramMenus> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isOpen = !_isOpen;
          });
        },
        child: Row(
          children: [
            DiagramFileMenu(
              isOpen: _isOpen,
            ),
            DiagramEditMenu(
              isOpen: _isOpen,
            ),
            Padding(
              padding: const EdgeInsets.all(2.5),
              child: UnsaveProgressButton(),
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                AppActionDispatcher().execute(CompileDiagramAction());
              },
              icon: Icon(Icons.help),
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ],
        ),
      ),
    );
  }
}
