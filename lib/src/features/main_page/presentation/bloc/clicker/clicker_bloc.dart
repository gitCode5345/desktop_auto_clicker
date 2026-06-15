import 'package:desktop_auto_clicker/src/run_clicker_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:desktop_auto_clicker/src/features/main_page/domain/entities/button_click_config.dart';

part 'clicker_event.dart';
part 'clicker_state.dart';

class ClickerBloc extends Bloc<ClickerEvent, ClickerState> {
  final RunClickerService runClickerService;
  ClickerBloc({required this.runClickerService}) : super(ClickerInitialState()) {
    on<StartClickingEvent>(_onStartClickingEvent);
    on<StopClickingEvent>(_onStopClickingEvent);
  }

  Future<void> _onStartClickingEvent(StartClickingEvent event, Emitter<ClickerState> emit) async {
    try {
      emit(ClickerLoadingState());

      int delay = event.delay;
      String button = event.button.name;

      runClickerService.startClicking(delay, button);

      emit(ClickerRunningState());
    }
    catch (e) {
      emit(ClickerErrorState('Error while starting clicking: $e'));
    }
  }

  Future<void> _onStopClickingEvent(StopClickingEvent event, Emitter<ClickerState> emit) async {
    try {
      emit(ClickerLoadingState());
      runClickerService.stopClicking();
      emit(ClickerStoppedState());
    }
    catch (e) {
      emit(ClickerErrorState('Error while stopping clicking: $e'));
    }
  }
}
