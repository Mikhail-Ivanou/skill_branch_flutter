import 'package:flutter/material.dart';

import 'app.dart';

void main() {
  runApp(MyApp());
}

class ConnectivityOverlay {
  static final ConnectivityOverlay _singleton = ConnectivityOverlay._internal();

  factory ConnectivityOverlay() {
    return _singleton;
  }

  ConnectivityOverlay._internal();

  static OverlayEntry overlayEntry;

  void showOverlay(BuildContext context, Widget child) {
    OverlayState overlayState = Overlay.of(context);

    overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return child;
      },
    );

    overlayState.insert(overlayEntry);
  }

  void removeOverlay(BuildContext context) {
    if (overlayEntry != null) {
      overlayEntry.remove();
    }
  }
}
