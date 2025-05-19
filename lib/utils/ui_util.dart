import 'package:flutter/material.dart';

final class UIUtils{

}

extension BuildContextEx on BuildContext{
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;
}