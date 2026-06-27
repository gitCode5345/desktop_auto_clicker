part of 'clicker_bloc.dart';

enum ClickerStatus { initial, loading, running, stopped, error }

class ClickerState extends Equatable {
  final ClickerStatus status;
  final ButtonClickConfigEntity? selectedButton;
  final String? errorMessage;

  const ClickerState({
    this.status = ClickerStatus.initial,
    this.selectedButton,
    this.errorMessage,
  });

  bool get isRunning => status == ClickerStatus.running;
  bool get isLoading => status == ClickerStatus.loading;
  bool get isBusy => isRunning || isLoading;

  double get cps {
    if (selectedButton == null || !isBusy) {
      return 0.0;
    }

    return msPerSecond / selectedButton!.delayMs!;
  }

  double get barHeight {
    if (selectedButton == null || !isBusy) {
      return minBarHeight;
    }

    int delayMs = selectedButton!.delayMs!;

    return maxBarHeight - ((delayMs - minSliderValue) * (maxBarHeight - minBarHeight) / (maxSliderValue - minSliderValue));
  }

  ClickerState copyWith({
    ClickerStatus? status,
    ButtonClickConfigEntity? selectedButton,
    String? errorMessage
  }) {
    return ClickerState(
      status: status ?? this.status,
      selectedButton: selectedButton ?? this.selectedButton,
      errorMessage: errorMessage
    );
  }

  @override
  List<Object?> get props => [
    status,
    selectedButton,
    errorMessage,
  ];
}
