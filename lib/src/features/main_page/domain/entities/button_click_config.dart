enum Button {
  leftMouseButton('left_mouse_button'),
  rightMouseButton('right_mouse_button');

  final String name;
  const Button(this.name);
}

class ButtonClickConfig {
  final String name;
  final Button button;

  const ButtonClickConfig({
    required this.name,
    required this.button,
  });
}
