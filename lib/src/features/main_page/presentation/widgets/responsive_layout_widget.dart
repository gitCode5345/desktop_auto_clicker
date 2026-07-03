import 'package:desktop_auto_clicker/src/core/constants/app_images.dart';
import 'package:desktop_auto_clicker/src/core/constants/dimensions.dart';
import 'package:desktop_auto_clicker/src/core/themes/app_color.dart';
import 'package:desktop_auto_clicker/src/features/main_page/presentation/widgets/main_content_widget.dart';
import 'package:desktop_auto_clicker/src/features/main_page/presentation/models/navigation_destination_item_model.dart';
import 'package:desktop_auto_clicker/src/features/main_page/presentation/widgets/sidebar_widget.dart';
import 'package:flutter/material.dart';

class ResponsiveLayoutWidget extends StatefulWidget {
  const ResponsiveLayoutWidget({super.key});

  @override
  State<ResponsiveLayoutWidget> createState() => _ResponsiveLayoutWidgetState();
}

class _ResponsiveLayoutWidgetState extends State<ResponsiveLayoutWidget> {
  late final List<NavigationDestinationItem> _destinations = const [
    NavigationDestinationItem(
      title: 'Головна',
      icon: AppImages.home,
      page: MainContentWidget(),
    ),
  ];

  int _selectedIndex = 0;

  void _selectDestination(int index) {
    if (index == _selectedIndex) {
      return;
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= largeDesktopBreakpoint;
        final currentPage = IndexedStack(
          index: _selectedIndex,
          children: _destinations.map((destination) => destination.page).toList(),
        );

        return Scaffold(
          backgroundColor: AppColor.windowBg,
          appBar: isDesktop
              ? null
              : AppBar(
                  backgroundColor: AppColor.sidebarBg,
                  foregroundColor: AppColor.textMain,
                  title: const Text('ClickStorm'),
                ),
          drawer: isDesktop
              ? null
              : SidebarWidget(
                  destinations: _destinations,
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (index) {
                    _selectDestination(index);
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
          body: isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SidebarWidget(
                      destinations: _destinations,
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: _selectDestination,
                    ),
                    Expanded(child: currentPage),
                  ],
                )
              : currentPage,
        );
      },
    );
  }
}
