import 'package:desktop_auto_clicker/src/core/themes/app_color.dart';
import 'package:flutter/material.dart';

class InterTextWidget extends StatelessWidget {
  final String data;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  const InterTextWidget({
    required this.data,
    this.fontSize = 14.0,
    this.color = AppColor.textMain,
    this.fontWeight = FontWeight.bold,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        fontFamily: 'Inter',
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight
      ),
    );
  }
}
