import 'package:flutter/material.dart';

class Themes {
  static const Gradient gradientBackground = LinearGradient(
      colors: [Color(0xffADF2F7), Color(0xffD3C4F2)], begin: Alignment.topLeft);
  static const Gradient menuGradient = LinearGradient(
      begin: Alignment.topCenter, colors: [Colors.white, Color(0xffB99AD9)]);
  static const Color menuItemBg = Color(0xffE4E4F2);
  static const TextStyle menuItemsTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle menuLabelStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
}
