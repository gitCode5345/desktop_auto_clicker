part of 'clicker_bloc.dart';

sealed class ClickerEvent extends Equatable {
  const ClickerEvent();

  @override
  List<Object?> get props => [];
}

final class StartClickingEvent extends ClickerEvent {
  final int delay;
  final ButtonClickConfig button;

  const StartClickingEvent({
    required this.delay,
    required this.button,
  });

  @override
  List<Object?> get props => [delay, button];
}

final class StopClickingEvent extends ClickerEvent {}
