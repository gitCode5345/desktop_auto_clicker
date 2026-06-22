import 'package:desktop_auto_clicker/src/features/main_page/presentation/widgets/info_container_widget.dart';
import 'package:flutter/material.dart';

class TappableContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  const TappableContainer({
    required this.child,
    this.padding,
    this.onTap,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: InfoContainerWidget(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
