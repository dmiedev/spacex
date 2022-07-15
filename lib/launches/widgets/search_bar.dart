import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key, this.hintText});

  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search, color: Colors.white),
        hintText: hintText,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
