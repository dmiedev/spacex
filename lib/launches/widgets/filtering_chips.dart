import 'package:flutter/material.dart';

class FilteringChips extends StatelessWidget {
  const FilteringChips({super.key});

  static const _chipIcons = [
    Icons.sort,
    Icons.history_toggle_off, // Icons.schedule
    Icons.rocket,
    Icons.date_range,
    Icons.tag,
    Icons.done,
  ];

  static const _chipTitles = [
    'Sorting',
    'Upcoming',
    'Rocket',
    'Year',
    'Flight Number',
    'Successfulness',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: _buildChip,
      itemCount: _chipIcons.length,
      separatorBuilder: (context, index) => const SizedBox(width: 10),
    );
  }

  Widget _buildChip(BuildContext context, int index) {
    return ActionChip(
      avatar: Icon(_chipIcons[index], size: 20),
      label: Text(_chipTitles[index]),
      onPressed: () {},
    );
  }

  void _handleSortingChipPress() {}

  void _handleTimeChipPress() {}

  void _handleRocketChipPress() {}
}
