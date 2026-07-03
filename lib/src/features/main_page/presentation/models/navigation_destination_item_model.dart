import 'package:flutter/widgets.dart';

class NavigationDestinationItem {
  final String title;
  final String icon;
  final Widget page;

  const NavigationDestinationItem({
    required this.title,
    required this.icon,
    required this.page,
  });
}
