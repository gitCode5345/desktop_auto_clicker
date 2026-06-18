import 'package:desktop_auto_clicker/src/core/usecases/usecase.dart';
import 'package:desktop_auto_clicker/src/features/main_page/domain/entities/button_click_config_entity.dart';
import 'package:desktop_auto_clicker/src/features/main_page/domain/repository/clicker_repository.dart';

class StartClickingUseCase implements UseCase<bool, ButtonClickConfigEntity> {
  final ClickerRepository _clickerRepository;
  const StartClickingUseCase(this._clickerRepository);

  @override
  Future<bool> call(ButtonClickConfigEntity params) {
    final isStarted = _clickerRepository.startClicking(params);
    return Future.value(isStarted);
  }
}
