import 'package:flutter/material.dart';

extension HexColor on Color {
  static Color fromHex(String hex) {
    final buffer = StringBuffer();
    if (hex.length == 6 || hex.length == 7) buffer.write('ff');
    buffer.write(hex.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

extension CapitalizeFirst on String {
  String capitalizeFirst() {
    return toUpperCase().substring(0, 1) + substring(1);
  }
}
