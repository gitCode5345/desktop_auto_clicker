import 'package:desktop_auto_clicker/src/features/main_page/domain/entities/button_click_config.dart';

class AvailableButtons {
  static const List<ButtonClickConfig> buttons = [
    ButtonClickConfig(
      name: 'Ліва кнопка миші',
      button: Button.leftMouseButton,
    ),
    ButtonClickConfig(
      name: 'Права кнопка миші',
      button: Button.rightMouseButton,
    ),
  ];
}
