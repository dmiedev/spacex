import 'package:flutter/material.dart';

/// A search bar that contains a clear button on the end.
class SearchBar extends StatelessWidget {
  /// Creates a search bar that contains a clear button on the end.
  const SearchBar({
    super.key,
    required this.controller,
    required this.onSubmitted,
    this.hintText,
  });

  final TextEditingController controller;

  /// Called on keyboard submission or clear button press.
  final void Function(String) onSubmitted;

  /// Text that is being displayed on this search bar when it is empty.
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextField(
      controller: controller,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search, color: colorScheme.onBackground),
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.onBackground),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.onBackground),
        ),
        suffixIcon: IconButton(
          onPressed: _handleClearButtonPress,
          icon: const Icon(Icons.clear),
          color: colorScheme.onBackground.withOpacity(0.5),
        ),
      ),
    );
  }

  void _handleClearButtonPress() {
    controller.clear();
    onSubmitted('');
  }
}
