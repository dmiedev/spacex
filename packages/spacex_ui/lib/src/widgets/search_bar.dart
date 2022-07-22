import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    required this.controller,
    required this.onSubmitted,
    this.hintText,
  });

  final TextEditingController controller;
  final void Function(String) onSubmitted;
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
