import 'package:flutter/material.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true, bool withAlpha = true}) => '${leadingHashSign ? '#' : ''}'
      '${withAlpha ? _floatToInt8(a).toRadixString(16).padLeft(2, '0') : ''}'
      '${_floatToInt8(r).toRadixString(16).padLeft(2, '0')}'
      '${_floatToInt8(g).toRadixString(16).padLeft(2, '0')}'
      '${_floatToInt8(b).toRadixString(16).padLeft(2, '0')}';

  static int _floatToInt8(double x) {
    return (x * 255.0).round() & 0xff;
  }
}
