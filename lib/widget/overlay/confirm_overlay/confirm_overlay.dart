import 'dart:async';

import 'package:fa_simulator/widget/components/button.dart';
import 'package:fa_simulator/widget/overlay/overlay_background.dart';
import 'package:fa_simulator/widget/overlay/overlay_body.dart';
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
        child: OverlayBody(
          child: Column(
            spacing: 10,
            children: [
              SizedBox(
                width: 150,
                child: Center(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelMedium,
                    softWrap: true,
                  ),
                ),
              ),
              Button(
                text: confirm ?? 'Confirm',
                onPressed: () {
                  completer.complete(true);
                },
                width: 150,
                height: 30,
              ),
              Button(
                text: cancle ?? 'Cancle',
                onPressed: () {
                  completer.complete(false);
                },
                width: 150,
                height: 30,
              ),
            ],
          ),
        ),
      );
    },
  );
}
