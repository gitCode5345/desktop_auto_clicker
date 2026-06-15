part of 'clicker_bloc.dart';

sealed class ClickerState extends Equatable {
  const ClickerState();

  @override
  List<Object> get props => [];
}

final class ClickerInitialState extends ClickerState {}

final class ClickerRunningState extends ClickerState {}

final class ClickerStoppedState extends ClickerState {}

final class ClickerErrorState extends ClickerState {
  final String message;

  const ClickerErrorState(this.message);

  @override
  List<Object> get props => [message];
}
