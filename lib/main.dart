import 'package:desktop_auto_clicker/src/features/main_page/domain/entities/button_click_config.dart';
import 'package:desktop_auto_clicker/src/features/main_page/domain/entities/available_buttons.dart';
import 'package:desktop_auto_clicker/src/features/main_page/presentation/bloc/clicker/clicker_bloc.dart';
import 'package:desktop_auto_clicker/src/run_clicker_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => ClickerBloc(runClickerService: RunClickerService()),
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
  final TextEditingController _controller = TextEditingController();

  ButtonClickConfig? selectedValue;

  final List<ButtonClickConfig> availableButtons = AvailableButtons.buttons;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
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
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter ms',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                ElevatedButton(
                  onPressed:() {
                    int ms = int.parse(_controller.text);
                    context.read<ClickerBloc>().add(
                      StartClickingEvent(
                        delay: ms,
                        button: selectedValue!
                      )
                    );
                  },
                  child: const Text('Start clicking'),
                ),
                ElevatedButton(
                  onPressed:() {
                    context.read<ClickerBloc>().add(
                      StopClickingEvent()
                    );
                  },
                  child: const Text('Stop clicking'),
                ),
              ]
            ),
          ],
        ),
      ),
    );
  }
}
