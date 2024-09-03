import 'package:fa_simulator/widget/body/body.dart';
import 'package:fa_simulator/widget/sidebar.dart';
import 'package:fa_simulator/widget/topbar.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      child: const Column(
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
                Sidebar(),
              ],
            ),
          ),
          Topbar(),
        ],
      ),
    );
  }
}
