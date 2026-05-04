import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration({
    required String hinText,
    required String labelText,
    IconData? prefixIcon,
  }) {
    return InputDecoration(
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.blueGrey),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.blueGrey, width: 3),
      ),
      hintText: hinText,
      labelText: labelText,
      prefixIcon: prefixIcon != null
          ? Icon(prefixIcon, color: Colors.blueGrey)
          : null,
    );
  }
}
