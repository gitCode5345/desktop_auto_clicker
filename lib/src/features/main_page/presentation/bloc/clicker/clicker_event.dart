part of 'clicker_bloc.dart';

sealed class ClickerEvent extends Equatable {
  const ClickerEvent();

  @override
  List<Object?> get props => [];
}

final class StartClickingEvent extends ClickerEvent {
  final ButtonClickConfigEntity button;

  const StartClickingEvent({
    required this.button
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

final class StopClickingEvent extends ClickerEvent {}
