import 'package:flutter/material.dart';

extension ConextHelper on BuildContext {
  // Sizes
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  double get shortestSide => MediaQuery.of(this).size.shortestSide;
  double get longestSide => MediaQuery.of(this).size.longestSide;
  Orientation get orientation => MediaQuery.of(this).orientation;
  // Sizes - Helpers
  double propHeight(double inputHeight) => (inputHeight / 812) * height;
  double propWidth(double inputWidth) => (inputWidth /  375) * width;
  double propFontSize(double inputFontSize) => (inputFontSize / 360) * width;
  // Theme
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
}
