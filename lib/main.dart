import 'package:desktop_auto_clicker/configs/injector/injector_conf.dart';
import 'package:desktop_auto_clicker/src/features/main_page/domain/entities/button_click_config_entity.dart';
import 'package:desktop_auto_clicker/src/core/constants/available_buttons.dart';
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

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController(text: '10');

  ButtonClickConfigEntity? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<ClickerBloc, ClickerState> (
          builder: (context, state) {
            // TODO: add another states for handling errors and loading
            final isRunning = state is ClickerRunningState;
            final isButtonSelected = selectedValue != null;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DropdownButton(
                  value: selectedValue,
                  items: availableButtons.map((button) {
                    return DropdownMenuItem(
                      value: button,
                      child: Text(button.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                ),
                TextField(
                  controller: _controller,
                  enabled: selectedValue != null ? true : false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter ms',
                  ),
                  onChanged: (value) {
                    setState(() {
                      selectedValue = selectedValue?.copyWith(
                        delayMs: int.tryParse(value) ?? 0);
                    });
                    context.read<ClickerBloc>().add(
                      UpdateClickingMsEvent(
                        button: selectedValue!
                      )
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: (!isRunning && isButtonSelected)? () {
                        int ms = int.parse(_controller.text);
                        context.read<ClickerBloc>().add(
                          StartClickingEvent(
                            button: selectedValue!.copyWith(delayMs: ms)
                          )
                        );
                      } : null,
                      child: const Text('Start clicking'),
                    ),
                    ElevatedButton(
                      onPressed: isRunning ? () {
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
