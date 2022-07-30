import 'package:flutter/material.dart';
import 'package:spacex/launch_filtering/widgets/widgets.dart';

/// A horizontal [ListView] with different launch filtering chips.
class LaunchFilteringChips extends StatelessWidget {
  /// Creates a horizontal [ListView] with different launch filtering chips.
  const LaunchFilteringChips({super.key});

  @override
  Widget build(BuildContext context) {
    const padding = SizedBox(width: 10);
    return ListView(
      scrollDirection: Axis.horizontal,
      children: const [
        LaunchSortingOrderChip(),
        padding,
        LaunchSortingChip(),
        _Divider(),
        LaunchTimeChip(),
        padding,
        LaunchRocketChip(),
        padding,
        LaunchYearRangeChip(),
        padding,
        LaunchFlightNumberChip(),
        padding,
        LaunchSuccessfulnessChip(),
        _Divider(),
        LaunchFilterSaveChip(),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: VerticalDivider(
        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
      ),
    );
  }
}
