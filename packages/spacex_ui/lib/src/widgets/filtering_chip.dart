import 'package:flutter/material.dart';

class FilteringChip extends StatelessWidget {
  const FilteringChip({
    super.key,
    this.icon,
    this.text,
    required this.active,
    required this.onPressed,
    this.tooltip,
  });

  final Widget? icon;
  final String? text;
  final bool active;
  final void Function() onPressed;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: icon != null
          ? IconTheme(
              data: IconThemeData(
                size: 20,
                color: active ? Colors.black : null,
              ),
              child: icon!,
            )
          : null,
      label: Text(
        text ?? '',
        style: TextStyle(color: active ? Colors.black : null),
      ),
      onPressed: onPressed,
      backgroundColor: active ? Colors.white : null,
      tooltip: tooltip,
    );
  }
}
