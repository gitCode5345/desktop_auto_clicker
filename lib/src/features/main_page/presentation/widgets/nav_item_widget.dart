import 'package:desktop_auto_clicker/src/core/themes/app_color.dart';
import 'package:flutter/material.dart';

class NavItemWidget extends StatelessWidget {
  final String title;
  final String icon;
  final bool isActive;

  const NavItemWidget({
    super.key,
    required this.title,
    required this.icon,
    this.isActive = false
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = AppColor.accent;

    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
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
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Inter',
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
