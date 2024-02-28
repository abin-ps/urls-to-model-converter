import 'package:flutter/material.dart';

class AppUtils {
  static void showSnackBar(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
