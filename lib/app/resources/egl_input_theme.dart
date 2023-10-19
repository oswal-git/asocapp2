import 'package:flutter/material.dart';

class EglInputTheme {
  TextStyle _builtTextStyle(Color color, {double size = 16.0, FontWeight fontWeight = FontWeight.normal}) {
    return TextStyle(
      color: color,
      fontSize: size,
      fontWeight: fontWeight,
    );
  }

  OutlineInputBorder _builtBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      borderSide: BorderSide(
        color: color,
        width: 1.0,
      ),
    );
  }

  InputDecorationTheme theme() => InputDecorationTheme(
        contentPadding: const EdgeInsets.all(12.0),
        // isDense seems to do nothing if you pass padding in
        isDense: true,
        // "always" put the label at the top
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // This can be useful for putting TextFields in a row
        // However, if might be more desirable to wrap with Flexible
        // to make then grow to the available width.
        constraints: const BoxConstraints(maxWidth: 350.0),

        // Borders
        // Enabled and not showing error
        enabledBorder: _builtBorder(Colors.grey.shade600),
        // Have error but not focus
        errorBorder: _builtBorder(Colors.red),
        // Has error and focus
        focusedErrorBorder: _builtBorder(Colors.red),
        // Default value if borders are null
        border: _builtBorder(Colors.yellow),
        // Enabled and focus
        focusedBorder: _builtBorder(Colors.blue),
        // Disabled
        disabledBorder: _builtBorder(Colors.grey.shade400),

        // TextStyles
        suffixStyle: _builtTextStyle(Colors.black),
        counterStyle: _builtTextStyle(Colors.grey, size: 12.0),
        floatingLabelStyle: _builtTextStyle(Colors.black),
        // Make error and helper the same size, so that the field
        // does not grow in height when there is an error text
        helperMaxLines: 2,
        errorMaxLines: 2,
        errorStyle: _builtTextStyle(Colors.red, size: 12.0),
        helperStyle: _builtTextStyle(Colors.black, size: 12.0),
        hintStyle: _builtTextStyle(Colors.grey, size: 12.0),
        labelStyle: _builtTextStyle(Colors.black, size: 18.0, fontWeight: FontWeight.bold),
        prefixStyle: _builtTextStyle(Colors.black),
      );
}
