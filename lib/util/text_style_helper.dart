import 'dart:io';

import 'package:flutter/material.dart';

class TextStyleHelper {
  static TextStyle small({fontWeight = FontWeight.normal, color, TextDecoration? decoration}) =>
      TextStyle(fontSize: (Platform.isIOS || Platform.isAndroid) ? 12.0 : 14.0, fontWeight: fontWeight, color: color, decoration: decoration);

  static TextStyle body({fontWeight = FontWeight.normal, color, TextDecoration? decoration}) =>
      TextStyle(fontSize: (Platform.isIOS || Platform.isAndroid) ? 14 : 18.0, fontWeight: fontWeight, color: color, decoration: decoration);

  static TextStyle big({fontWeight = FontWeight.normal, color, TextDecoration? decoration}) =>
      TextStyle(fontSize: (Platform.isIOS || Platform.isAndroid) ? 20.0 : 30, fontWeight: fontWeight, color: color, decoration: decoration);
}
