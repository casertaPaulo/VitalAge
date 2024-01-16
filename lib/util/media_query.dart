import 'package:flutter/material.dart';

// Função estática que retorna o tipo de dispositivo
class Util {
  static String getDeviceType(BuildContext context) {
    final data = MediaQuery.of(context);
    return data.size.shortestSide < 550 ? 'phone' : 'tablet';
  }
}
