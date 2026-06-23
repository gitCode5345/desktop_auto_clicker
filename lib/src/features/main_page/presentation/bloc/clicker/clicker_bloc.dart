import 'package:desktop_auto_clicker/src/core/usecases/usecase.dart';
import 'package:desktop_auto_clicker/src/features/main_page/domain/usecases/start_clicking.dart';
import 'package:desktop_auto_clicker/src/features/main_page/domain/usecases/stop_clicking.dart';
import 'package:desktop_auto_clicker/src/features/main_page/domain/usecases/update_clicking_ms.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:desktop_auto_clicker/src/features/main_page/domain/entities/button_click_config_entity.dart';

part 'clicker_event.dart';
part 'clicker_state.dart';

class ClickerBloc extends Bloc<ClickerEvent, ClickerState> {
  final StartClickingUseCase _startClickingUseCase;
  final UpdateClickingMsUseCase _updateClickingMsUseCase;
  final StopClickingUseCase _stopClickingUseCase;

  ClickerBloc(
      this._startClickingUseCase,
      this._stopClickingUseCase,
      this._updateClickingMsUseCase
    ) : super(ClickerState()) {
    on<SelectButtonEvent>((event, emit) {
      emit(state.copyWith(selectedButton: event.button));
    });
    on<StartClickingEvent>(_onStartClickingEvent);
    on<StopClickingEvent>(_onStopClickingEvent);
    on<UpdateClickingMsEvent>(_onUpdateClickingMsEvent);
  }

  Future<void> _onStartClickingEvent(StartClickingEvent event, Emitter<ClickerState> emit) async {
    try {
      emit(state.copyWith(status: ClickerStatus.loading));
      final isRunning = await _startClickingUseCase(event.button);

      emit(state.copyWith(
        status: isRunning? ClickerStatus.running : ClickerStatus.error,
        errorMessage: isRunning ? null : 'Failed to start clicking.'
      ));
    }
    catch (e) {
      emit(state.copyWith(
        status: ClickerStatus.error,
        errorMessage: 'Error $e'
      ));
    }
  }

  Future<void> _onStopClickingEvent(StopClickingEvent event, Emitter<ClickerState> emit) async {
    try {
      emit(state.copyWith(status: ClickerStatus.loading));
      final isStopped = await _stopClickingUseCase(NoParams());

      emit(state.copyWith(
        status: isStopped? ClickerStatus.stopped : ClickerStatus.error,
        errorMessage: isStopped ? null : 'Failed to stop clicking.'
      ));
    }
    catch (e) {
      emit(state.copyWith(
        status: ClickerStatus.error,
        errorMessage: 'Error $e'
      ));
    }
  }

  Future<void> _onUpdateClickingMsEvent(UpdateClickingMsEvent event, Emitter<ClickerState> emit) async {
    try {
      emit(state.copyWith(
        selectedButton: event.button
      ));
      await _updateClickingMsUseCase(event.button);
    }
    catch (e) {
      emit(state.copyWith(
        status: ClickerStatus.error,
        errorMessage: 'Error $e'
      ));
    }
  }
}
