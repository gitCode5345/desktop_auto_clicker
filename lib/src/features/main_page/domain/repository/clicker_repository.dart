import 'package:desktop_auto_clicker/src/features/main_page/domain/entities/button_click_config_entity.dart';

abstract class ClickerRepository {
  bool startClicking(ButtonClickConfigEntity button);
  void updateClickingMs(ButtonClickConfigEntity button);
  bool stopClicking();
}
