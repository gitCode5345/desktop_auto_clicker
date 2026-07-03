import 'package:desktop_auto_clicker/src/core/constants/app_images.dart';
import 'package:desktop_auto_clicker/src/core/constants/dimensions.dart';
import 'package:desktop_auto_clicker/src/core/themes/app_color.dart';
import 'package:desktop_auto_clicker/src/features/main_page/presentation/widgets/info_container_widget.dart';
import 'package:desktop_auto_clicker/src/features/main_page/presentation/widgets/nav_item_widget.dart';
import 'package:desktop_auto_clicker/src/features/main_page/presentation/models/navigation_destination_item_model.dart';
import 'package:desktop_auto_clicker/src/features/main_page/presentation/widgets/inter_text_widget.dart';
import 'package:desktop_auto_clicker/src/features/main_page/presentation/widgets/tappable_container_widget.dart';
import 'package:flutter/material.dart';

class SidebarWidget extends StatelessWidget {
  final List<NavigationDestinationItem> destinations;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const SidebarWidget({
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    super.key
  });

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
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 8),
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
          const SizedBox(height: 32),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var index = 0; index < destinations.length; index++) ...[
                      NavItemWidget(
                        title: destinations[index].title,
                        icon: destinations[index].icon,
                        isActive: index == selectedIndex,
                        onTap: () => onDestinationSelected(index),
                      ),
                      if (index != destinations.length - 1)
                        const SizedBox(height: 8),
                    ],
                  ],
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
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InfoContainerWidget(
                        padding: const EdgeInsets.all(8.0),
                        child: InterTextWidget(
                          data: 'Клавіша F6',
                          fontSize: 11,
                          color: infoTextColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TappableContainerWidget(
                        onTap: () => debugPrint('Toggle theme'),
                        padding: const EdgeInsets.all(8.0),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
