import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toasts {
  static showFailure(BuildContext context,String message) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Theme.of(context).colorScheme.primary,
      textColor: Colors.black,
      fontSize: 16.sp,
    );
  }

  static showSuccess(BuildContext context, String message) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Theme.of(context).colorScheme.primary,
        textColor: Colors.black,
        fontSize: 16.sp);
  }
}
