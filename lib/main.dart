import 'package:desktop_auto_clicker/src/run_clicker_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
  final RunClickerService _service = RunClickerService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
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
                    _service.startClicking(ms, 'left_mouse_button');
                  },
                  child: const Text('Start clicking'),
                ),
                ElevatedButton(
                  onPressed:() {
                    _service.stopClicking();
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
