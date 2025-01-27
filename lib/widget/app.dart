import 'package:fa_simulator/widget/body/body.dart';
import 'package:fa_simulator/widget/sidebar/sidebar.dart';
import 'package:fa_simulator/widget/top_bar/diagram_top_bar.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        verticalDirection: VerticalDirection.up,
        children: [
          Expanded(
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Body(),
                    ],
                  ),
                ),
                SideBar(),
              ],
            ),
          ),
          DiagramTopBar(),
        ],
      ),
    );
  }
}
