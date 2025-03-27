import 'package:flutter/material.dart';

class Keyboardutil {
  static void hideKeyboard (BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if(!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}