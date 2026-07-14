import 'package:desktop_auto_clicker/src/core/enums/button.dart';
import 'package:desktop_auto_clicker/src/features/main_page/domain/entities/button_click_config_entity.dart';

const List<ButtonClickConfigEntity> availableButtons = [
  ButtonClickConfigEntity(
    name: 'Ліва кнопка миші (ЛКМ)',
    button: Button.leftMouseButton,
  ),
  ButtonClickConfigEntity(
    name: 'Права кнопка миші (ПКМ)',
    button: Button.rightMouseButton,
  ),
];
