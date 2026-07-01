part of 'clicker_bloc.dart';

enum ClickerStatus { initial, loading, countdown, running, stopped, error }

class ClickerState extends Equatable {
  final ClickerStatus status;
  final ButtonClickConfigEntity? selectedButton;
  final int? delayedStartSeconds;
  final String? errorMessage;

  const ClickerState({
    this.status = ClickerStatus.initial,
    this.selectedButton,
    this.delayedStartSeconds,
    this.errorMessage,
  });

  bool get isRunning => status == ClickerStatus.running;
  bool get isLoading => status == ClickerStatus.loading;
  bool get isCountdown => status == ClickerStatus.countdown;

  bool get isBusy => isRunning || isLoading || isCountdown;
  bool get isStoppable => isRunning || isCountdown;

  double get cps {
    if (selectedButton == null || !isRunning) {
      return 0.0;
    }

    return msPerSecond / selectedButton!.delayMs!;
  }

  double get barHeight {
    if (selectedButton == null || !isRunning) {
      return minBarHeight;
    }

    int delayMs = selectedButton!.delayMs!;

    return maxBarHeight - ((delayMs - minSliderValue) * (maxBarHeight - minBarHeight) / (maxSliderValue - minSliderValue));
  }

  ClickerState copyWith({
    ClickerStatus? status,
    ButtonClickConfigEntity? selectedButton,
    int? delayedStartSeconds,
    String? errorMessage
  }) {
    return ClickerState(
      status: status ?? this.status,
      selectedButton: selectedButton ?? this.selectedButton,
      delayedStartSeconds: delayedStartSeconds ?? this.delayedStartSeconds,
      errorMessage: errorMessage
    );
  }

  @override
  List<Object?> get props => [
    status,
    selectedButton,
    delayedStartSeconds,
    errorMessage,
  ];
}
