import 'package:desktop_auto_clicker/app_view.dart';
import 'package:desktop_auto_clicker/configs/injector/injector_conf.dart';
import 'package:desktop_auto_clicker/src/features/main_page/presentation/bloc/clicker/clicker_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ClickerBloc>(),
      child: const AppView(),
    );
  }
}
