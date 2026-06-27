import 'dart:async';

import 'package:desktop_auto_clicker/src/core/constants/dimensions.dart';
import 'package:desktop_auto_clicker/src/core/themes/app_color.dart';
import 'package:desktop_auto_clicker/src/features/main_page/presentation/widgets/info_container_widget.dart';
import 'package:flutter/material.dart';

class CpsGraphWidget extends StatefulWidget {
  final bool isRunning;
  final double targetBarHeight;

  const CpsGraphWidget({
    required this.isRunning,
    required this.targetBarHeight,
    super.key,
  });

  @override
  State<CpsGraphWidget> createState() => _CpsGraphWidgetState();
}

class _BarData {
  final double height;
  final bool isPulse;
  const _BarData(this.height, this.isPulse);
}

class _CpsGraphWidgetState extends State<CpsGraphWidget> {
  static const int barCount = 18;
  late List<_BarData> _bars = List.generate(
    barCount,
    (_) => const _BarData(minBarHeight, false)
  );
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _syncTicker();
  }

  @override
  void didUpdateWidget(CpsGraphWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncTicker();
  }

  void _syncTicker() {
    if (widget.isRunning && _ticker == null) {
      _ticker = Timer.periodic(
        const Duration(milliseconds: 100),
        (_) => _tick()
      );
    } else if (!widget.isRunning && _ticker != null) {
      _ticker?.cancel();
      _ticker = null;
      setState(() {
        _bars = List.generate(barCount, (_) => const _BarData(minBarHeight, false));
      });
    }
  }

  void _tick() {
    setState(() {
      _bars.removeAt(0);
      _bars.add(_BarData(widget.targetBarHeight, true));
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final duration = widget.isRunning
        ? const Duration(milliseconds: 90)
        : const Duration(milliseconds: 1200);

    return InfoContainerWidget(
      height: 60.0,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: _bars.map((bar) {
          return Expanded(
            child: AnimatedContainer(
              height: bar.height,
              duration: duration,
              curve: Curves.easeOut,
              margin: const EdgeInsets.only(right: 2.0),
              decoration: BoxDecoration(
                color: bar.isPulse ? AppColor.success : AppColor.accent.withAlpha(76),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(2.0),
                  topRight: Radius.circular(2.0),
                ),
                border: const Border(
                  top: BorderSide(
                    color: AppColor.border,
                    width: 1.0
                  )
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
