// import 'package:fa_simulator/widget/components/diagram_tile.dart';
// import 'package:fa_simulator/provider/diagram_provider/command/diagram_list.dart';
// import 'package:fa_simulator/widget/provider/file_provider.dart';
// import 'package:flutter/material.dart';

// class DiagramRow extends StatelessWidget {
//   const DiagramRow({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final String name =
//         FileProvider().fileName ?? 'unnamed.${FileProvider().faTypeString}';

//     return ListView(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       children: [
//         DiagramTile(
//           leading: 'Diagram:',
//           body: name,
//         ),
//         DiagramTile(
//           leading: 'Type:',
//           body: FileProvider().faTypeString,
//         ),
//         DiagramTile(
//           leading: 'States:',
//           body: DiagramList().states.length.toString(),
//         ),
//         DiagramTile(
//           leading: 'Transitions:',
//           body: DiagramList().transitions.length.toString(),
//         ),
//       ],
//     );
//   }
// }
