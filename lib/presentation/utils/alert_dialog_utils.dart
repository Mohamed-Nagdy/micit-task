import 'package:flutter/cupertino.dart';

mixin AlertDialogMixin {
  void showCupertinoAlertDialog(
    BuildContext context,
    String title,
    String message, {
    void Function()? onCancel,
    void Function()? onConfirm,
  }) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: onCancel,
                child: const Text('Cancel'),
              ),
              CupertinoDialogAction(
                onPressed: onConfirm,
                child: const Text('Confirm'),
              ),
            ],
          );
        });
  }
}
