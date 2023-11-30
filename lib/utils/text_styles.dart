import 'dart:ui';

import 'package:flutter/material.dart';

class TextStyles {
  static const _baseStyle = TextStyle(fontFamily: 'Switzer');

  static TextStyle h1 = _baseStyle.copyWith(
      fontSize: 32, fontVariations: [const FontVariation("wght", 700)]);
  static TextStyle h2 = _baseStyle.copyWith(
      fontSize: 28, fontVariations: [const FontVariation("wght", 700)]);
  static TextStyle h3 = _baseStyle.copyWith(
      fontSize: 24, fontVariations: [const FontVariation("wght", 600)]);
  static TextStyle h4 = _baseStyle.copyWith(
      fontSize: 20, fontVariations: [const FontVariation("wght", 600)]);
  static TextStyle normal = _baseStyle.copyWith(
      fontSize: 16, fontVariations: [const FontVariation("wght", 500)]);
}
