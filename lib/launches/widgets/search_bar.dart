import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    this.controller,
    this.hintText,
    this.onSubmitted,
    this.onClearButtonPressed,
  });

  final TextEditingController? controller;
  final String? hintText;
  final void Function(String)? onSubmitted;
  final void Function()? onClearButtonPressed;

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
          onPressed: onClearButtonPressed,
          icon: const Icon(Icons.clear),
        ),
      ),
    );
  }
}
