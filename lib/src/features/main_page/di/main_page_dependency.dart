import 'package:desktop_auto_clicker/src/configs/injector/injector_conf.dart';
import 'package:desktop_auto_clicker/src/features/main_page/data/data_sources/ffi/run_clicker_service.dart';
import 'package:desktop_auto_clicker/src/features/main_page/data/repository/clicker_repository_impl.dart';
import 'package:desktop_auto_clicker/src/features/main_page/domain/usecases/start_clicking.dart';
import 'package:desktop_auto_clicker/src/features/main_page/domain/usecases/stop_clicking.dart';
import 'package:desktop_auto_clicker/src/features/main_page/domain/usecases/update_clicking_ms.dart';
import 'package:desktop_auto_clicker/src/features/main_page/presentation/bloc/clicker/clicker_bloc.dart';

class MainPageDependency {
  MainPageDependency._();

  static void init() {
    getIt.registerFactory(
      () => ClickerBloc(
        getIt<StartClickingUseCase>(),
        getIt<StopClickingUseCase>(),
        getIt<UpdateClickingMsUseCase>()
      )
    );

    getIt.registerLazySingleton(
      () => StartClickingUseCase(
        getIt<ClickerRepositoryImpl>()
      )
    );

    getIt.registerLazySingleton(
      () => StopClickingUseCase(
        getIt<ClickerRepositoryImpl>()
      )
    );

    getIt.registerLazySingleton(
      () => UpdateClickingMsUseCase(
        getIt<ClickerRepositoryImpl>()
      )
    );
    
    getIt.registerLazySingleton(
      () => ClickerRepositoryImpl(
        runClickerService: getIt<RunClickerService>()
      )
    );

    getIt.registerLazySingleton(
      () => RunClickerService()
    );
  }
}
