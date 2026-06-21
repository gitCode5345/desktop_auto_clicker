import 'dart:ui';

import 'package:desktop_auto_clicker/configs/injector/injector_conf.dart';
import 'package:desktop_auto_clicker/src/core/usecases/usecase.dart';
import 'package:desktop_auto_clicker/src/features/main_page/domain/entities/button_click_config_entity.dart';
import 'package:desktop_auto_clicker/src/core/constants/available_buttons.dart';
import 'package:desktop_auto_clicker/src/features/main_page/domain/usecases/stop_clicking.dart';
import 'package:desktop_auto_clicker/src/features/main_page/presentation/bloc/clicker/clicker_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();

  runApp(
    BlocProvider(
      create: (_) => getIt<ClickerBloc>(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final TextEditingController _controller = TextEditingController(text: '10');
  ButtonClickConfigEntity? selectedValue;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<AppExitResponse> didRequestAppExit() async {
    final bloc = context.read<ClickerBloc>();

    if (bloc.state.isRunning) {
      await getIt<StopClickingUseCase>()(NoParams());
    }

    return AppExitResponse.exit;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<ClickerBloc, ClickerState> (
          builder: (context, state) {
            // TODO: add another states for handling errors and loading
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DropdownButton(
                  value: state.selectedButton,
                  items: availableButtons.map((button) {
                    return DropdownMenuItem<ButtonClickConfigEntity>(
                      value: button,
                      child: Text(button.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      context.read<ClickerBloc>().add(
                        SelectButtonEvent(button: value)
                      );
                    }
                  },
                ),
                TextField(
                  controller: _controller,
                  enabled: state.selectedButton != null && !state.isRunning,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter ms',
                  ),
                  onChanged: (value) {
                    final ms = int.tryParse(value) ?? 0;
                    final updated = state.selectedButton!.copyWith(delayMs: ms);
                    context.read<ClickerBloc>().add(
                      UpdateClickingMsEvent(
                        button: updated
                      )
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: (!state.isRunning && state.selectedButton != null)? () {
                        int ms = int.parse(_controller.text);
                        context.read<ClickerBloc>().add(
                          StartClickingEvent(
                            button: state.selectedButton!.copyWith(delayMs: ms)
                          )
                        );
                      } : null,
                      child: const Text('Start clicking'),
                    ),
                    ElevatedButton(
                      onPressed: state.isRunning ? () {
                        context.read<ClickerBloc>().add(
                          StopClickingEvent()
                        );
                      } : null,
                      child: const Text('Stop clicking'),
                    ),
                  ]
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
