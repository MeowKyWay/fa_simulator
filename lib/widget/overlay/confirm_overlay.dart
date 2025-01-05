import 'dart:async';

import 'package:fa_simulator/config/theme.dart';
import 'package:fa_simulator/widget/components/button.dart';
import 'package:fa_simulator/widget/overlay/overlay_background.dart';
import 'package:flutter/material.dart';

Future<bool> confirm(String message, BuildContext context,
    {String? confirm, String? cancle}) async {
  Completer<bool> completer = Completer<bool>();

  OverlayEntry overlay =
      _confirmOverlay(completer, message, confirm: confirm, cancle: cancle);

  Overlay.of(context).insert(overlay);

  return await completer.future.then((value) {
    overlay.remove();
    return value;
  });
}

OverlayEntry _confirmOverlay(Completer<bool> completer, String message,
    {String? confirm, String? cancle}) {
  return OverlayEntry(
    builder: (context) {
      return OverlayBackground(
        child: Container(
          decoration: BoxDecoration(
            color: secondaryColor,
            border: Border.all(
              color: primaryLineColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Button(
                    text: confirm ?? 'Confirm',
                    onPressed: () {
                      completer.complete(true);
                    },
                    width: 200,
                    height: 40,
                  ),
                  Button(
                    text: cancle ?? 'Cancle',
                    onPressed: () {
                      completer.complete(false);
                    },
                    width: 200,
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
