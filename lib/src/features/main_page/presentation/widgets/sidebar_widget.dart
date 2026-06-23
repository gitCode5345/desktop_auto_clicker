import 'package:desktop_auto_clicker/src/core/constants/app_images.dart';
import 'package:desktop_auto_clicker/src/core/constants/dimensions.dart';
import 'package:desktop_auto_clicker/src/core/themes/app_color.dart';
import 'package:desktop_auto_clicker/src/features/main_page/presentation/widgets/info_container_widget.dart';
import 'package:desktop_auto_clicker/src/features/main_page/presentation/widgets/nav_item_widget.dart';
import 'package:desktop_auto_clicker/src/features/main_page/presentation/widgets/inter_text_widget.dart';
import 'package:desktop_auto_clicker/src/features/main_page/presentation/widgets/tappable_container_widget.dart';
import 'package:flutter/material.dart';

class SidebarWidget extends StatelessWidget {
  const SidebarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final accentColor = AppColor.accent;
    final containerColor = AppColor.sidebarBg;
    final borderColor = AppColor.border;
    final infoTextColor = AppColor.textMuted;

    return Container(
      width: sideBarWidth,
      decoration: BoxDecoration(
        color: containerColor,
        border: Border(
          right: BorderSide(
            color: borderColor,
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 24,
        horizontal: 12
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(width: 8),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.all(5.0),
                child: Image.asset(
                  AppImages.logo,
                )
              ),
              const SizedBox(width: 8),
              InterTextWidget(
                data: 'ClickStorm',
                fontSize: 18.0,
              )
            ],
          ),
          const SizedBox(height: 32),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TODO: make enum for nav items
                NavItemWidget(
                  title: 'Головна',
                  icon: AppImages.home,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: containerColor,
              border: Border(
                top: BorderSide(
                  color: borderColor,
                  width: 1,
                ),
              ),
            ),
            padding: EdgeInsets.only(top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoContainerWidget(
                  padding: EdgeInsets.all(8.0),
                  child: InterTextWidget(
                    data: 'Клавіша F6',
                    fontSize: 11,
                    color: infoTextColor,
                  ),
                ),
                const SizedBox(height: 16),
                TappableContainerWidget(
                  onTap: () => debugPrint('Toggle theme'),
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.sunMoon,
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(width: 8),
                      InterTextWidget(
                        data: 'Тема',
                        fontSize: 13,
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
