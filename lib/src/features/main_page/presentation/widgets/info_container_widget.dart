import 'package:desktop_auto_clicker/src/core/themes/app_color.dart';
import 'package:flutter/material.dart';

class InfoContainerWidget extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;

  const InfoContainerWidget({
    required this.child,
    this.padding,
    this.width = double.infinity,
    this.height,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final containerColor = AppColor.inputBg;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: containerColor,
        border: Border.all(
          color: AppColor.border,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: padding,
      child: child,
    );
  }
}
