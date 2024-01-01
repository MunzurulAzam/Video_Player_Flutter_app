// import 'package:atrai/src/controllers/services/user_message/snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

devPrint(dynamic message, {Color color = Colors.green}) {
  if (kDebugMode) {
    print("[Log] - $message");
    // showToast(title: null, message: message);
  }
}
