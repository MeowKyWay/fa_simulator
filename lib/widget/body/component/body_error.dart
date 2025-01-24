import 'package:fa_simulator/widget/diagram/diagram_manager/diagram_list/diagram_list.dart';
import 'package:fa_simulator/widget/provider/error_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BodyError extends StatelessWidget {
  const BodyError({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DiagramList>(builder: (context, provider, child) {
      ErrorProvider().checkErrors();
      return Container();
    });
  }
}
