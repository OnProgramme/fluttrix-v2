import 'package:flutter/material.dart';

Color parseIntegerColor(int colorInt) {
  int alpha = (colorInt >> 24) & 0xFF;
  int red = (colorInt >> 16) & 0xFF;
  int green = (colorInt >> 8) & 0xFF;
  int blue = colorInt & 0xFF;
  return Color.fromARGB(alpha, red, green, blue);
}
