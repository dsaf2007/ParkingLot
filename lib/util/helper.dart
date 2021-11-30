import "package:flutter/material.dart";

ButtonStyle buildDoubleButtonStyle(Color bgColor, Size minSize) {
  return TextButton.styleFrom(
    backgroundColor: bgColor,
    minimumSize: minSize,
  );
}
