import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_shorts_app/core/managers/styles_manager/color_manager.dart';

abstract class ToastHelper {
  static void showToast({
    required String message,
    Color color = ColorController.redColor,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: ColorController.whiteColor,
      fontSize: 16.0,
    );
  }
}
