import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/number_symbols.dart';

extension PercentSized on double {
  double get hp => (Get.height * (this / 100));
  double get wp => (Get.width * (this / 100));
}

extension ResposiveText on double {
  double get sp => (Get.width / 100 * (this / 3));
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

extension StringExtensions on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isWithespace() => trim().isEmpty;

  bool isValidPassword() => length > 5;

  bool isValidDouble() => double.tryParse(this) != null;

  bool isValidInt() => int.tryParse(this) != null;

  String s() => length == 1 ? '' : 's';
}

extension IntExtensions on int {
//   String s(int value) => value > 1 ? 's' : '';
  String get s => this == 1 ? '' : 's';
}

extension EglPadding on num {
  SizedBox get ph => SizedBox(
        height: toDouble(),
      );
  SizedBox get pw => SizedBox(
        width: toDouble(),
      );
}

extension EglesES on NumberSymbols {
  NumberSymbols copyWith({
    String? currencySymbol,
  }) {
    return NumberSymbols(
        NAME: NAME,
        DECIMAL_SEP: DECIMAL_SEP,
        GROUP_SEP: GROUP_SEP,
        PERCENT: PERCENT,
        ZERO_DIGIT: ZERO_DIGIT,
        PLUS_SIGN: PLUS_SIGN,
        MINUS_SIGN: MINUS_SIGN,
        EXP_SYMBOL: EXP_SYMBOL,
        PERMILL: PERMILL,
        INFINITY: INFINITY,
        NAN: NAN,
        DECIMAL_PATTERN: DECIMAL_PATTERN,
        SCIENTIFIC_PATTERN: SCIENTIFIC_PATTERN,
        PERCENT_PATTERN: PERCENT_PATTERN,
        CURRENCY_PATTERN: CURRENCY_PATTERN,
        DEF_CURRENCY_CODE: currencySymbol ?? DEF_CURRENCY_CODE);
  }
}
