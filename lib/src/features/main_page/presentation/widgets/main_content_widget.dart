import 'dart:ui';

import 'package:desktop_auto_clicker/src/configs/injector/injector_conf.dart';
import 'package:desktop_auto_clicker/src/core/constants/available_buttons.dart';
import 'package:desktop_auto_clicker/src/core/constants/dimensions.dart';
import 'package:desktop_auto_clicker/src/core/enums/button.dart';
import 'package:desktop_auto_clicker/src/core/themes/app_color.dart';
import 'package:desktop_auto_clicker/src/core/usecases/usecase.dart';
import 'package:desktop_auto_clicker/src/features/main_page/domain/usecases/stop_clicking.dart';
import 'package:desktop_auto_clicker/src/features/main_page/presentation/bloc/clicker/clicker_bloc.dart';
import 'package:desktop_auto_clicker/src/features/main_page/presentation/widgets/card_widget.dart';
import 'package:desktop_auto_clicker/src/features/main_page/presentation/widgets/dropdown_container.dart';
import 'package:desktop_auto_clicker/src/features/main_page/presentation/widgets/info_container_widget.dart';
import 'package:desktop_auto_clicker/src/features/main_page/presentation/widgets/inter_text_widget.dart';
import 'package:desktop_auto_clicker/src/features/main_page/presentation/widgets/start_button_widget.dart';
import 'package:desktop_auto_clicker/src/features/main_page/presentation/widgets/stop_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainContentWidget extends StatefulWidget {
  const MainContentWidget({super.key});

  @override
  State<MainContentWidget> createState() => _MainContentWidgetState();
}

class _MainContentWidgetState extends State<MainContentWidget> with WidgetsBindingObserver {
  late final TextEditingController _controllerMs;
  final FocusNode _focusMs = FocusNode();

  late final TextEditingController _delayStartController;
  final FocusNode _delayStartFocus = FocusNode();

  double _sliderValue = 10;
  int _delayStartSeconds = 0;
  bool _delayStartIsChecked = false;

  int _validateAndClampMs() {
    final value = (int.tryParse(_controllerMs.text) ?? 10).clamp(10, 1000);
    _controllerMs.text = value.toString();
    return value;
  }

  @override
  void initState() {
    final currentMs = context.read<ClickerBloc>().state.selectedButton?.delayMs ?? 10;
    _controllerMs = TextEditingController(text: currentMs.toString());
    _delayStartController = TextEditingController(text: '0');

    WidgetsBinding.instance.addObserver(this);
    _focusMs.addListener(() {
      if (!_focusMs.hasFocus) {
        _validateAndClampMs();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    _controllerMs.dispose();
    _delayStartController.dispose();

    _focusMs.dispose();
    _delayStartFocus.dispose();
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
    final bgColor = AppColor.windowBg;
    final cardBgColor = AppColor.cardBg;
    final textColor = AppColor.textMain;

    return Container(
      decoration: BoxDecoration(
        color: bgColor
      ),
      child: SingleChildScrollView(
        child: Center(
          child: BlocBuilder<ClickerBloc, ClickerState> (
            builder: (context, state) {
              // TODO: add another states for handling errors and loading
              return ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: mainContentMaxWidth
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 40.0,
                    horizontal: 24.0
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final isWide = constraints.maxWidth >= 992;
                      if (isWide) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _buildLeftPart(
                                cardBgColor,
                                state,
                                context,
                                bgColor,
                                textColor
                              )
                            ),
                            SizedBox(width: 30.0),
                            SizedBox(
                              width: 320.0,
                              child: _buildProgressCardWidget(cardBgColor, state)
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            _buildLeftPart(
                              cardBgColor,
                              state,
                              context,
                              bgColor,
                              textColor
                            ),
                            SizedBox(height: 30.0),
                            _buildProgressCardWidget(cardBgColor, state)
                          ],
                        );
                      }
                    },
                  )
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  CardWidget _buildProgressCardWidget(Color cardBgColor, ClickerState state) {
    return CardWidget(
      color: cardBgColor,
      padding: const EdgeInsets.symmetric(
        vertical: 40.0,
        horizontal: 24.0
      ),
      child: Column(
        children: [
          InterTextWidget(
            data: 'Продуктивність'.toUpperCase(),
            color: AppColor.textMuted,
            letterSpacing: 1.0,
            fontWeight: FontWeight.w700
          ),
          const SizedBox(height: 32.0),
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0.0, end: state.cps),
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOut,
            builder: (context, value, child) {
              return InterTextWidget(
                data: value.toStringAsFixed(1),
                color: AppColor.accent,
                fontSize: 64.0,
                fontWeight: FontWeight.w900
              );
            },
          ),
          const SizedBox(height: 12.0),
          InterTextWidget(
            data: 'Clicks per second'.toUpperCase(),
            color: AppColor.textMuted,
            fontSize: 11.0,
            letterSpacing: 1.0
          ),
          const SizedBox(height: 20.0),
          InfoContainerWidget(
            height: 60.0,
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(18, (index) => Expanded(
                child: Container(
                  height: 10.0,
                  decoration: BoxDecoration(
                    color: AppColor.accent.withAlpha(76),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(2.0)
                    )
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 2.0),
                ),
              )),
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 8.0,
                height: 8.0,
                decoration: BoxDecoration(
                  color: AppColor.textMuted,
                  shape: BoxShape.circle
                ),
              ),
              const SizedBox(width: 8.0),
              InterTextWidget(
                data: 'Статус: очікування',
                color: AppColor.textMuted,
                fontSize: 13.0
              )
            ],
          )
        ],
      ),
    );
  }

  Column _buildLeftPart(Color cardBgColor, ClickerState state, BuildContext context, Color bgColor, Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InterTextWidget(
          data: 'Конфігурація клікера',
          fontSize: 24.0,
        ),
        const SizedBox(height: 8.0),
        InterTextWidget(
          data: 'Керування тригерами та швидкістю',
          fontSize: 13.0,
          color: AppColor.textMuted,
        ),
        const SizedBox(height: 24.0),
        CardWidget(
          padding: const EdgeInsets.all(24.0),
          color: cardBgColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InterTextWidget(
                data: 'Тригери'.toUpperCase(),
                color: AppColor.textMuted,
                letterSpacing: 1.0,
              ),
              const SizedBox(height: 20.0),
              InterTextWidget(
                data: 'Кнопка дії',
                fontSize: 13.0,
                color: AppColor.textMuted
              ),
              const SizedBox(height: 8.0),
              DropdownContainer<Button>(
                value: state.selectedButton?.button,
                enabled: !state.isBusy,
                items: availableButtons.map((b) => b.button).toList(),
                labelBuilder: (btn) => availableButtons.firstWhere((b) => b.button == btn).name,
                onChanged: (btn) {
                  if (btn != null) {
                    final entity = availableButtons
                      .firstWhere((b) => b.button == btn)
                      .copyWith(delayMs: state.selectedButton?.delayMs);
                    context.read<ClickerBloc>().add(SelectButtonEvent(button: entity));
                  }
                },
              )
            ],
          ),
        ),
        const SizedBox(height: 24.0),
        CardWidget(
          color: cardBgColor,
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InterTextWidget(
                data: 'Затримка та швидкість'.toUpperCase(),
                color: AppColor.textMuted,
                letterSpacing: 1.0,
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InterTextWidget(
                    data: 'Інтервали кліку',
                    fontSize: 13.0,
                    color: AppColor.textMain,
                  ),
                  Container(
                    width: 90,
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 8.0
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.inputBg,
                      border: Border.all(color: AppColor.border, width: 1),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controllerMs,
                            focusNode: _focusMs,
                            enabled: !state.isBusy,
                            textAlign: TextAlign.right,
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            style: const TextStyle(
                              color: AppColor.textMain,
                              fontSize: 14.0,
                              fontFamily: 'Inter',
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            onChanged: (value) {
                              final ms = int.tryParse(value) ?? 0;
                              _sliderValue = ms.toDouble().clamp(10, 1000);
                              final updated = state.selectedButton!.copyWith(delayMs: ms);
                              context.read<ClickerBloc>().add(
                                UpdateClickingMsEvent(button: updated),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 6.0),
                        const InterTextWidget(
                          data: 'ms',
                          fontSize: 13.0,
                          color: AppColor.textMuted,
                          fontWeight: FontWeight.normal,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackShape: const RoundedRectSliderTrackShape(),
                  trackHeight: 8.0,
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
                  overlayShape: SliderComponentShape.noOverlay,
                ),
                child: Slider(
                  value: _sliderValue,
                  min: 10,
                  max: 1000,
                  activeColor: bgColor,
                  inactiveColor: bgColor,
                  thumbColor: AppColor.accent,
                  onChanged: (state.selectedButton != null && !state.isBusy)? (value) {
                    setState(() => _sliderValue = value);
                    final ms = value.toInt().clamp(10, 1000);
                    _controllerMs.text = ms.toString();
                    final updated = state.selectedButton!.copyWith(delayMs: ms);
                    context.read<ClickerBloc>().add(
                      UpdateClickingMsEvent(button: updated),
                    );
                  } : null
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: AppColor.border, width: 1),
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _delayStartIsChecked,
                          onChanged: (value) {
                            setState(() {
                              _delayStartIsChecked = value!;
                            });
                          }
                        ),
                        InterTextWidget(
                          data: 'Відкладений старт'
                        )
                      ],
                    ),
                    Container(
                      width: 90,
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 8.0
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.inputBg,
                        border: Border.all(color: AppColor.border, width: 1),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _delayStartController,
                              focusNode: _delayStartFocus,
                              enabled: state.selectedButton != null && !state.isBusy,
                              textAlign: TextAlign.right,
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              style: const TextStyle(
                                color: AppColor.textMain,
                                fontSize: 14.0,
                                fontFamily: 'Inter',
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  // TODO: added event if start is delayed
                                  int seconds = int.tryParse(value) ?? 0;
                                  _delayStartSeconds = seconds.clamp(0, 60);
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 6.0),
                          const InterTextWidget(
                            data: 'seconds',
                            fontSize: 13.0,
                            color: AppColor.textMuted,
                            fontWeight: FontWeight.normal,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StartButtonWidget(
              enabled: state.selectedButton != null && !state.isBusy,
              onTap: () {
                int ms = _validateAndClampMs();
                context.read<ClickerBloc>().add(
                  StartClickingEvent(
                    button: state.selectedButton!.copyWith(delayMs: ms)
                  )
                );
              },
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 24.0
              ),
              child: Center(
                child: InterTextWidget(
                  data: 'Start clicking',
                  fontSize: 16.0,
                ),
              )
            ),
            const SizedBox(width: 16.0),
            StopButtonWidget(
              enabled: state.isRunning,
              onTap: () {
                context.read<ClickerBloc>().add(
                  StopClickingEvent()
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.stop, size: 16.0, color: textColor),
                  const SizedBox(width: 10.0),
                  InterTextWidget(
                    data: 'Стоп',
                    color: textColor,
                    fontSize: 15.0,
                  ),
                ],
              ),
            ),
          ]
        ),
      ],
    );
  }
}
