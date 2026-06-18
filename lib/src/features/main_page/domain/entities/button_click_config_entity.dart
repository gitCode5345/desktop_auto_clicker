import 'package:desktop_auto_clicker/src/core/enums/button.dart';
import 'package:equatable/equatable.dart';

class ButtonClickConfigEntity extends Equatable{
  final String name;
  final Button button;
  final int? delayMs;

  const ButtonClickConfigEntity({
    required this.name,
    required this.button,
    this.delayMs
  });

  ButtonClickConfigEntity copyWith({
    String? name,
    Button? button,
    int? delayMs
  }) {
    return ButtonClickConfigEntity(
      name: name ?? this.name,
      button: button ?? this.button,
      delayMs: delayMs ?? this.delayMs
    );
  }

  @override
  List<Object?> get props => [name, button];
}
