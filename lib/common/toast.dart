// lib/common/toast.dart

import 'package:flutter/material.dart';

class Toast {
  static void show(BuildContext context, String message,
      {Duration duration = const Duration(seconds: 4),
      required SnackBarAction action,
      SnackBarBehavior behavior = SnackBarBehavior.floating,
      double elevation = 6.0,
      EdgeInsetsGeometry margin =
          const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 12.0),
      Color backgroundColor = Colors.black87,
      Color actionTextColor = Colors.white}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        action: action,
        behavior: behavior,
        elevation: elevation,
        margin: margin,
        backgroundColor: backgroundColor,
        // actionTextColor: actionTextColor,
      ),
    );
  }
}
