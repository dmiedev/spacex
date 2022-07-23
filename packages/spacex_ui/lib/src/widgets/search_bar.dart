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

  /// Controls the text being edited.
  final TextEditingController controller;

  /// Called on keyboard submission or clear button press.
  final void Function(String) onSubmitted;

  /// Text that is being displayed on this search bar when it is empty.
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search, color: Colors.white),
        hintText: hintText,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        suffixIcon: IconButton(
          onPressed: _handleClearButtonPress,
          icon: const Icon(Icons.clear),
          color: Colors.grey,
        ),
      ),
    );
  }

  void _handleClearButtonPress() {
    controller.clear();
    onSubmitted('');
  }
}
