import 'package:flutter/material.dart';

class InterTextWidget extends StatelessWidget {
  final String data;
  final double fontSize;
  final Color color;

  const InterTextWidget({
    required this.data,
    this.fontSize = 14.0,
    this.color = Colors.white,
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
        fontWeight: FontWeight.bold
      ),
    );
  }
}
