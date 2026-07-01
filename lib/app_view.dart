import 'package:desktop_auto_clicker/src/features/main_page/presentation/bloc/clicker/clicker_bloc.dart';
import 'package:desktop_auto_clicker/src/features/main_page/presentation/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  void initState() {
    _registerF6Hotkey();
    super.initState();
  }

  Future<void> _registerF6Hotkey() async {
    final hotKey = HotKey(
      key: PhysicalKeyboardKey.f6,
      modifiers: [],
      scope: HotKeyScope.system
    );

    await hotKeyManager.register(
      hotKey,
      keyDownHandler: (_) {
        final bloc = context.read<ClickerBloc>();
        final state = bloc.state;

        if (state.selectedButton != null && !state.isBusy) {
          bloc.add(StartClickingEvent(
            button: state.selectedButton!,
            delayedStartSeconds: state.delayedStartSeconds ?? 0
          ));
        } else if (state.isStoppable) {
          bloc.add(state.isRunning ? StopClickingEvent() : CancelDelayedStartEvent());
        }
      }
    );
  }

  @override
  void dispose() {
    hotKeyManager.unregister(
      HotKey(
        key: PhysicalKeyboardKey.f6,
        scope: HotKeyScope.system
      )
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ClickStorm',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MainPage(),
    );
  }
}
