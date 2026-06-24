import 'package:desktop_auto_clicker/src/core/themes/app_color.dart';
import 'package:desktop_auto_clicker/src/features/main_page/presentation/widgets/inter_text_widget.dart';
import 'package:flutter/material.dart';

class DropdownContainer<T> extends StatefulWidget {
  final T? value;
  final List<T> items;
  final String Function(T item) labelBuilder;
  final ValueChanged<T?>? onChanged;
  final EdgeInsetsGeometry? padding;
  final bool enabled;

  const DropdownContainer({
    required this.items,
    required this.labelBuilder,
    required this.onChanged,
    this.value,
    this.padding,
    this.enabled = true,
    super.key,
  });

  @override
  State<DropdownContainer<T>> createState() => _DropdownContainerState<T>();
}

class _DropdownContainerState<T> extends State<DropdownContainer<T>> {
  bool _isOpen = false;

  Future<void> _openMenu() async {
    final button = context.findRenderObject() as RenderBox;
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    final position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(button.size.bottomLeft(Offset.zero), ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    setState(() => _isOpen = true);

    final selected = await showMenu<T>(
      context: context,
      position: position,
      color: AppColor.inputBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: AppColor.border),
      ),
      constraints: BoxConstraints(minWidth: button.size.width),
      items: widget.items.map((item) {
        return PopupMenuItem<T>(
          value: item,
          child: InterTextWidget(data: widget.labelBuilder(item), fontWeight: FontWeight.normal),
        );
      }).toList(),
    );

    setState(() => _isOpen = false);

    if (selected != null) {
      widget.onChanged?.call(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    final label = widget.value != null ? widget.labelBuilder(widget.value as T) : '';

    return GestureDetector(
      onTap: widget.enabled ? _openMenu : null,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.inputBg,
          border: Border.all(color: AppColor.border, width: 1),
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InterTextWidget(data: label, fontWeight: FontWeight.normal),
            AnimatedRotation(
              turns: _isOpen ? 0.5 : 0,
              duration: const Duration(milliseconds: 200),
              child: const Icon(Icons.keyboard_arrow_down, color: AppColor.textMuted),
            ),
          ],
        ),
      ),
    );
  }
}
