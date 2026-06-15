part of 'clicker_bloc.dart';

sealed class ClickerEvent extends Equatable {
  const ClickerEvent();

  @override
  List<Object?> get props => [];
}

final class StartClickingEvent extends ClickerEvent {}

final class StopClickingEvent extends ClickerEvent {}
