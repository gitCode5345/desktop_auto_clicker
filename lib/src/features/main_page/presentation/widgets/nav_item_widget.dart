import 'package:desktop_auto_clicker/src/core/themes/app_color.dart';
import 'package:desktop_auto_clicker/src/features/main_page/presentation/widgets/inter_text_widget.dart';
import 'package:flutter/material.dart';

class NavItemWidget extends StatelessWidget {
  final String title;
  final String icon;
  final bool isActive;
  final VoidCallback? onTap;

  const NavItemWidget({
    required this.title,
    required this.icon,
    this.isActive = false,
    this.onTap,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = isActive ? AppColor.accent : AppColor.border;
    final backgroundColor = isActive
        ? AppColor.accent.withValues(alpha: 0.12)
        : Colors.transparent;
    final textColor = isActive ? AppColor.textMain : AppColor.textMuted;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border(
              left: BorderSide(
                color: borderColor,
                width: 2,
              ),
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(3.0),
              bottomLeft: Radius.circular(3.0)
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 10.0,
          ),
          child: Row(
            children: [
              const SizedBox(width: 8),
              Image.asset(
                icon,
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 8),
              InterTextWidget(
                data: title,
                color: textColor,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              )
            ],
          ),
        ),
      ),
    );
  }
}
