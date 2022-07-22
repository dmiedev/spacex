import 'package:flutter/material.dart';
import 'package:spacex/launch_filtering/widgets/widgets.dart';

class LaunchFilteringChips extends StatelessWidget {
  const LaunchFilteringChips({super.key});

  @override
  Widget build(BuildContext context) {
    const padding = SizedBox(width: 10);
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        const LaunchSortingOrderChip(),
        padding,
        const LaunchSortingChip(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: VerticalDivider(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
          ),
        ),
        const LaunchTimeChip(),
        padding,
        const LaunchRocketChip(),
        padding,
        const LaunchYearRangeChip(),
        padding,
        const LaunchFlightNumberChip(),
        padding,
        const LaunchSuccessfulnessChip(),
      ],
    );
  }
}
