import 'package:desktop_auto_clicker/src/core/themes/app_color.dart';
import 'package:flutter/material.dart';

class InfoContainerWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const InfoContainerWidget({
    required this.child,
    this.padding,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final containerColor = AppColor.inputBg;

    return Container(
      width: double.infinity,
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
