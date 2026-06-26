import 'package:desktop_auto_clicker/app.dart';
import 'package:desktop_auto_clicker/src/configs/injector/injector_conf.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();

  runApp(const App());
}
