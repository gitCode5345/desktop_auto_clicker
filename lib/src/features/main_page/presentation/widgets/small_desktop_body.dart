import 'package:desktop_auto_clicker/src/core/themes/app_color.dart';
import 'package:desktop_auto_clicker/src/features/main_page/presentation/widgets/main_content_widget.dart';
import 'package:desktop_auto_clicker/src/features/main_page/presentation/widgets/sidebar_widget.dart';
import 'package:flutter/material.dart';

class SmallDesktopBody extends StatelessWidget {
  const SmallDesktopBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Desktop Auto Clicker'),
      ),
      backgroundColor: AppColor.windowBg,
      drawer: SidebarWidget(),
      body: MainContentWidget(),
    );
  }
}
