import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'clicker_event.dart';
part 'clicker_state.dart';

class ClickerBloc extends Bloc<ClickerEvent, ClickerState> {
  ClickerBloc() : super(ClickerInitialState()) {
    on<ClickerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
