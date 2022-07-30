import 'package:flutter/material.dart';

/// A search bar that contains a clear button on the end.
class SearchBar extends StatefulWidget {
  /// Creates a search bar that contains a clear button on the end.
  const SearchBar({
    super.key,
    required this.onSubmitted,
    this.hintText,
  });

  /// Called on keyboard submission or clear button press.
  final void Function(String) onSubmitted;

  /// Text that is being displayed on this search bar when it is empty.
  final String? hintText;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextField(
      controller: _controller,
      onSubmitted: widget.onSubmitted,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search, color: colorScheme.onBackground),
        hintText: widget.hintText,
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
    _controller.clear();
    widget.onSubmitted('');
  }
}
