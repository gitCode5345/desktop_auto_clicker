import 'package:desktop_auto_clicker/src/core/usecases/usecase.dart';
import 'package:desktop_auto_clicker/src/features/main_page/domain/repository/clicker_repository.dart';

class StopClickingUseCase implements UseCase<bool, NoParams> {
  final ClickerRepository _clickerRepository;
  const StopClickingUseCase(this._clickerRepository);

  @override
  Future<bool> call(NoParams params) {
    final isStopped = _clickerRepository.stopClicking();
    return Future.value(isStopped);
  }
}
