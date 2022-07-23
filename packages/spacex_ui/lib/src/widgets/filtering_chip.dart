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
    final colorScheme = Theme.of(context).colorScheme;
    return ActionChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            IconTheme(
              data: IconThemeData(
                size: 20,
                color:
                    active ? colorScheme.onSecondary : colorScheme.onBackground,
              ),
              child: icon!,
            ),
          if (icon != null && label != null) const SizedBox(width: 7.5),
          if (label != null)
            Text(
              label!,
              style: TextStyle(
                color:
                    active ? colorScheme.onSecondary : colorScheme.onBackground,
              ),
            ),
        ],
      ),
      onPressed: onPressed,
      backgroundColor: active ? colorScheme.secondary : null,
      tooltip: tooltip,
    );
  }
}
