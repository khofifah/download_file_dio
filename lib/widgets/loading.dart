import 'package:flutter/material.dart';

Future<void> showLoading(BuildContext context) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Material(
        type: MaterialType.transparency,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    },
  );
}

Future<void> hideLoading(BuildContext context) async {
  Navigator.pop(context);
}
