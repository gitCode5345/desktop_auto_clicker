import 'package:desktop_auto_clicker/src/features/main_page/data/data_sources/ffi/run_clicker_service.dart';
import 'package:desktop_auto_clicker/src/features/main_page/domain/entities/button_click_config_entity.dart';
import 'package:desktop_auto_clicker/src/features/main_page/domain/repository/clicker_repository.dart';

class ClickerRepositoryImpl implements ClickerRepository {
  final RunClickerService runClickerService;

  const ClickerRepositoryImpl({
    required this.runClickerService,
  });

  @override
  bool startClicking(ButtonClickConfigEntity button) {
    runClickerService.startClicking(button);
    return runClickerService.isClicking();
  }

  @override
  void updateClickingMs(ButtonClickConfigEntity button) {
    runClickerService.updateClickingMs(button);
  }

  @override
  bool stopClicking() {
    runClickerService.stopClicking();
    return runClickerService.isClicking();
  }
}
