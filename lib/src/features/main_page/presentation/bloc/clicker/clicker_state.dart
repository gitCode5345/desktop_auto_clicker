part of 'clicker_bloc.dart';

enum ClickerStatus { initial, loading, running, stopped, error }

class ClickerState extends Equatable {
  final ClickerStatus status;
  final double cpsCount;
  final ButtonClickConfigEntity? selectedButton;
  final String? errorMessage;

  const ClickerState({
    this.status = ClickerStatus.initial,
    this.selectedButton,
    this.cpsCount = 0.0,
    this.errorMessage,
  });

  bool get isRunning => status == ClickerStatus.running;
  bool get isLoading => status == ClickerStatus.loading;
  bool get isBusy => isRunning || isLoading;

  ClickerState copyWith({
    ClickerStatus? status,
    ButtonClickConfigEntity? selectedButton,
    double? cpsCount,
    String? errorMessage
  }) {
    return ClickerState(
      status: status ?? this.status,
      selectedButton: selectedButton ?? this.selectedButton,
      cpsCount: cpsCount ?? this.cpsCount,
      errorMessage: errorMessage
    );
  }

  @override
  List<Object?> get props => [
    status,
    selectedButton,
    cpsCount,
    errorMessage,
  ];
}
