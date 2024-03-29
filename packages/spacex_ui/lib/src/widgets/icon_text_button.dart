import 'package:flutter/material.dart';

/// A button whose body contains an icon and text.
class IconTextButton extends StatelessWidget {
  /// Creates a button whose body contains an icon and text.
  const IconTextButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  /// The icon this button displays.
  final Widget icon;

  /// The label string this button displays.
  final String label;

  /// Called when the user presses on this button.
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor:
            MaterialStateColor.resolveWith((states) => colorScheme.secondary),
        foregroundColor:
            MaterialStateColor.resolveWith((states) => colorScheme.onSecondary),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: 5),
          Text(label),
        ],
      ),
    );
  }
}
