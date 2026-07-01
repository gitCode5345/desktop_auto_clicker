import 'package:desktop_auto_clicker/app.dart';
import 'package:desktop_auto_clicker/src/configs/injector/injector_conf.dart';
import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();

  await hotKeyManager.unregisterAll();

  runApp(const App());
}
