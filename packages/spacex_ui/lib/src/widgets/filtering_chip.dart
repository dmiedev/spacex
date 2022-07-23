import 'package:flutter/material.dart';

/// A chip that represents a filtering option.
class FilteringChip extends StatelessWidget {
  /// Creates a chip that represents a filtering option.
  const FilteringChip({
    super.key,
    this.icon,
    this.label,
    required this.active,
    required this.onPressed,
    this.tooltip,
  });

  /// An icon to display prior to the chip's label.
  final Widget? icon;

  /// A label string to display on this chip.
  final String? label;

  /// Whether this chip is active.
  final bool active;

  /// Called when the user presses on this chip.
  final void Function() onPressed;

  /// Tooltip string to be used for the body area of this chip.
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
        label ?? '',
        style: TextStyle(color: active ? Colors.black : null),
      ),
      onPressed: onPressed,
      backgroundColor: active ? Colors.white : null,
      tooltip: tooltip,
    );
  }
}
