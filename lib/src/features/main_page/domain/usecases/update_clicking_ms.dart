import 'package:desktop_auto_clicker/src/core/usecases/usecase.dart';
import 'package:desktop_auto_clicker/src/features/main_page/domain/entities/button_click_config_entity.dart';
import 'package:desktop_auto_clicker/src/features/main_page/domain/repository/clicker_repository.dart';

class UpdateClickingMsUseCase implements UseCase<void, ButtonClickConfigEntity> {
  final ClickerRepository _clickerRepository;
  const UpdateClickingMsUseCase(this._clickerRepository);

  @override
  Future<void> call(ButtonClickConfigEntity params) {
    _clickerRepository.updateClickingMs(params);
    return Future.value();
  }
}
