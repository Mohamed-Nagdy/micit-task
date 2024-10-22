import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastType {
  success,
  error,
  info;

  Color get toastColor {
    switch (this) {
      case success:
        return Colors.green;
      case error:
        return Colors.red;
      case info:
        return Colors.blue;
    }
  }
}

mixin ToastUtils {
  void showToast({
    required String message,
    ToastType toastType = ToastType.success,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: toastType.toastColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
