import 'package:desktop_auto_clicker/src/core/enums/button.dart';
import 'package:desktop_auto_clicker/src/features/main_page/domain/entities/button_click_config_entity.dart';

const List<ButtonClickConfigEntity> availableButtons = [
  ButtonClickConfigEntity(
    name: 'Left Mouse Button',
    button: Button.leftMouseButton,
  ),
  ButtonClickConfigEntity(
    name: 'Right Mouse Button',
    button: Button.rightMouseButton,
  ),
];
