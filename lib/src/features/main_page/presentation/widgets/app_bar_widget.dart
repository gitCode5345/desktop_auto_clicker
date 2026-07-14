import 'package:desktop_auto_clicker/src/core/constants/app_images.dart';
import 'package:desktop_auto_clicker/src/core/constants/dimensions.dart';
import 'package:desktop_auto_clicker/src/core/themes/app_color.dart';
import 'package:desktop_auto_clicker/src/features/main_page/presentation/widgets/inter_text_widget.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {

  const AppBarWidget({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(appBarHeight);

  @override
  Widget build(BuildContext context) {
    final accentColor = AppColor.accent;
    final menuContainerColor = AppColor.inputBg;
    final iconColor = AppColor.textMain;
    final containerColor = AppColor.sidebarBg;
    final borderColor = AppColor.border;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 20.0
      ),
      decoration: BoxDecoration(
        color: containerColor,
        border: Border(
          top: BorderSide(
            color: borderColor,
            width: 1.0
          )
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(5.0),
                child: Image.asset(AppImages.logo),
              ),
              const SizedBox(width: 8),
              const InterTextWidget(
                data: 'ClickStorm',
                fontSize: 18.0,
              ),
            ],
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: menuContainerColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  Icons.menu,
                  color: iconColor,
                  size: 20.0
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
