part of 'clicker_bloc.dart';

sealed class ClickerEvent extends Equatable {
  const ClickerEvent();

  @override
  List<Object?> get props => [];
}

final class SelectButtonEvent extends ClickerEvent {
  final ButtonClickConfigEntity button;

  const SelectButtonEvent({
    required this.button
  });

  @override
  List<Object?> get props => [button];
}

final class StartClickingEvent extends ClickerEvent {
  final ButtonClickConfigEntity button;
  final int delayedStartSeconds;

  const StartClickingEvent({
    required this.button,
    this.delayedStartSeconds = 0
  });

  @override
  List<Object?> get props => [button];
}

final class UpdateClickingMsEvent extends ClickerEvent {
  final ButtonClickConfigEntity button;

  const UpdateClickingMsEvent({
    required this.button
  });

  @override
  List<Object?> get props => [button];
}

final class UpdateDelayedStartSecondsEvent extends ClickerEvent {
  final int delayedStartSeconds;

  const UpdateDelayedStartSecondsEvent({
    required this.delayedStartSeconds
  });

  @override
  List<Object?> get props => [delayedStartSeconds];
}

final class StopClickingEvent extends ClickerEvent {}

final class CancelDelayedStartEvent extends ClickerEvent {}
