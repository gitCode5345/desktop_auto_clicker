import 'package:desktop_auto_clicker/src/core/themes/app_color.dart';
import 'package:flutter/material.dart';

class StopButtonWidget extends StatelessWidget {
  final Widget child;
  final bool enabled;
  final VoidCallback? onTap;

  const StopButtonWidget({
    required this.child,
    required this.enabled,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MouseRegion(
        cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.forbidden,
        child: GestureDetector(
          onTap: enabled ? onTap : null,
          child: AnimatedOpacity(
            opacity: enabled ? 1.0 : 0.5,
            duration: const Duration(milliseconds: 150),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
              decoration: BoxDecoration(
                color: enabled ? AppColor.danger : AppColor.danger.withAlpha(25),
                border: Border.all(color: AppColor.danger.withAlpha(25), width: 1),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: child
            ),
          ),
        ),
      ),
    );
  }
}
