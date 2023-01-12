import 'package:flutter/material.dart';

class Spaces {
  dynamic verticalSpace(double size) {
    return SizedBox(
      height: size,
    );
  }

  dynamic horizontalSpace(double size) {
    return SizedBox(
      width: size,
    );
  }
}
