import 'package:desktop_auto_clicker/src/features/main_page/presentation/widgets/main_content_widget.dart';
import 'package:desktop_auto_clicker/src/features/main_page/presentation/widgets/sidebar_widget.dart';
import 'package:flutter/material.dart';

class LargeDesktopBody extends StatelessWidget {
  const LargeDesktopBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SidebarWidget(),
          Expanded(
            child: MainContentWidget()
          ),
        ],
      ),
    );
  }
}
