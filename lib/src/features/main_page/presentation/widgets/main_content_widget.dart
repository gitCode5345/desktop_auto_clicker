import 'dart:ui';

import 'package:desktop_auto_clicker/configs/injector/injector_conf.dart';
import 'package:desktop_auto_clicker/src/core/constants/available_buttons.dart';
import 'package:desktop_auto_clicker/src/core/usecases/usecase.dart';
import 'package:desktop_auto_clicker/src/features/main_page/domain/entities/button_click_config_entity.dart';
import 'package:desktop_auto_clicker/src/features/main_page/domain/usecases/stop_clicking.dart';
import 'package:desktop_auto_clicker/src/features/main_page/presentation/bloc/clicker/clicker_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainContentWidget extends StatefulWidget {
  const MainContentWidget({super.key});

  @override
  State<MainContentWidget> createState() => _MainContentWidgetState();
}

class _MainContentWidgetState extends State<MainContentWidget> with WidgetsBindingObserver {
  late final TextEditingController _controller;
  final FocusNode _focus = FocusNode();

  int _validateAndClampMs() {
    final value = (int.tryParse(_controller.text) ?? 10).clamp(10, 1000);
    _controller.text = value.toString();
    return value;
  }

  @override
  void initState() {
    final currentMs = context.read<ClickerBloc>().state.selectedButton?.delayMs ?? 10;
    _controller = TextEditingController(text: currentMs.toString());

    WidgetsBinding.instance.addObserver(this);
    _focus.addListener(() {
      if (!_focus.hasFocus) {
        _validateAndClampMs();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Future<AppExitResponse> didRequestAppExit() async {
    final bloc = context.read<ClickerBloc>();

    if (bloc.state.isRunning) {
      await getIt<StopClickingUseCase>()(NoParams());
    }

    return AppExitResponse.exit;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<ClickerBloc, ClickerState> (
        builder: (context, state) {
          // TODO: add another states for handling errors and loading
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownButton(
                value: state.selectedButton,
                items: availableButtons.map((button) {
                  return DropdownMenuItem<ButtonClickConfigEntity>(
                    value: button.copyWith(delayMs: state.selectedButton?.delayMs),
                    child: Text(button.name),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    context.read<ClickerBloc>().add(
                      SelectButtonEvent(button: value)
                    );
                  }
                },
              ),
              TextField(
                controller: _controller,
                focusNode: _focus,
                enabled: state.selectedButton != null && !state.isBusy,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter ms',
                ),
                onChanged: (value) {
                  final ms = int.tryParse(value) ?? 0;
                  final updated = state.selectedButton!.copyWith(delayMs: ms);
                  context.read<ClickerBloc>().add(
                    UpdateClickingMsEvent(
                      button: updated
                    )
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: (!state.isBusy && state.selectedButton != null) ? () {
                      int ms = _validateAndClampMs();
                      context.read<ClickerBloc>().add(
                        StartClickingEvent(
                          button: state.selectedButton!.copyWith(delayMs: ms)
                        )
                      );
                    } : null,
                    child: const Text('Start clicking'),
                  ),
                  ElevatedButton(
                    onPressed: state.isRunning ? () {
                      context.read<ClickerBloc>().add(
                        StopClickingEvent()
                      );
                    } : null,
                    child: const Text('Stop clicking'),
                  ),
                ]
              ),
            ],
          );
        },
      ),
    );
  }
}
