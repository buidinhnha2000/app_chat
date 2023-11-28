import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../extensions/extensions.dart';

class BottomSheetChat {
  const BottomSheetChat._();

  static void show(
    BuildContext context, {
    required Widget child,
    bool hasListenerVerticalDrag = true,
  }) {
    showMaterialModalBottomSheet<void>(
      context: context,
      backgroundColor: context.theme.colorScheme.onPrimary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (BuildContext context) {
        return GestureDetector(child: child);
      },
    );
  }
}
