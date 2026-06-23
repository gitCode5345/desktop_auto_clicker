import 'package:desktop_auto_clicker/src/core/constants/dimensions.dart';
import 'package:desktop_auto_clicker/src/features/main_page/presentation/widgets/large_desktop_body.dart';
import 'package:desktop_auto_clicker/src/features/main_page/presentation/widgets/small_desktop_body.dart';
import 'package:flutter/material.dart';

class ResponsiveLayoutWidget extends StatelessWidget {
  const ResponsiveLayoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrained) {
        if (constrained.maxWidth < smallDesktopWidth) {
          return const SmallDesktopBody();
        } else {
          return const LargeDesktopBody();
        }
      },
    );
  }
}
