import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:spacex/launches/bloc/bloc.dart';
import 'package:spacex_api/spacex_api.dart';

const _chipIconSize = 20.0;

class FilteringChips extends StatelessWidget {
  const FilteringChips({super.key});

  @override
  Widget build(BuildContext context) {
    const padding = SizedBox(width: 10);

    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        const _SortingOrderChip(),
        padding,
        const _SortingChip(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: VerticalDivider(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
          ),
        ),
        const _TimeChip(),
        padding,
        const _RocketChip(),
        padding,
        const _DateChip(),
        padding,
        const _FlightNumberChip(),
        padding,
        const _SuccessfulnessChip(),
      ],
    );
  }
}

class _SortingOrderChip extends StatelessWidget {
  const _SortingOrderChip({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaunchBloc, LaunchState>(
      buildWhen: (previous, current) =>
          previous.sortingOption.order != current.sortingOption.order,
      builder: (context, state) => ActionChip(
        label: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationX(
            state.sortingOption.order == SortOrder.ascending ? math.pi : 0,
          ),
          child: const Icon(Icons.sort, size: _chipIconSize),
        ),
        tooltip: 'Sorting order',
        onPressed: () => _handlePress(context),
      ),
    );
  }

  void _handlePress(BuildContext context) {
    context.read<LaunchBloc>().add(LaunchSortingOrderSwitched());
  }
}

class _SortingChip extends StatelessWidget {
  const _SortingChip({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaunchBloc, LaunchState>(
      buildWhen: (previous, current) =>
          previous.sortingOption.feature != current.sortingOption.feature,
      builder: (context, state) => ActionChip(
        label: Text(
          _mapLaunchFeatureToLabel(state.sortingOption.feature),
          style: const TextStyle(color: Colors.black),
        ),
        onPressed: () => _handlePress(context),
        backgroundColor: Colors.white,
      ),
    );
  }

  String _mapLaunchFeatureToLabel(LaunchFeature feature) {
    switch (feature) {
      case LaunchFeature.date:
        return 'Sorting by Date';
      case LaunchFeature.name:
        return 'Sorting by Name';
      case LaunchFeature.flightNumber:
        return 'Sorting by Flight Number';
      // ignore: no_default_cases
      default:
        break;
    }
    return 'Sorting';
  }

  Future<void> _handlePress(BuildContext context) async {
    final launchBloc = context.read<LaunchBloc>();
    final feature = await showDialog<LaunchFeature>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Select Sorting'),
        children: [
          SimpleDialogOption(
            child: const Text('Date'),
            onPressed: () => Navigator.pop(context, LaunchFeature.date),
          ),
          SimpleDialogOption(
            child: const Text('Name'),
            onPressed: () => Navigator.pop(context, LaunchFeature.name),
          ),
          SimpleDialogOption(
            child: const Text('Flight Number'),
            onPressed: () => Navigator.pop(context, LaunchFeature.flightNumber),
          ),
        ],
      ),
    );
    if (feature != null) {
      launchBloc.add(LaunchSortingOptionAdded(feature: feature));
    }
  }
}

class _TimeChip extends StatelessWidget {
  const _TimeChip({super.key});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: const Icon(Icons.history_toggle_off, size: _chipIconSize),
      label: const Text('Upcoming'),
      onPressed: _handlePress,
    );
  }

  void _handlePress() {
    // TODO(dmiedev): Switch upcoming to past, past to upcoming
  }
}

class _RocketChip extends StatelessWidget {
  const _RocketChip({super.key});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: const Icon(Icons.rocket, size: _chipIconSize),
      label: const Text('Rocket'),
      onPressed: () => _handlePress(context),
    );
  }

  void _handlePress(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Sorting'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CheckboxListTile(
              title: const Text('Rocket 1'),
              value: false,
              onChanged: (_) {},
            ),
            CheckboxListTile(
              title: const Text('Rocket 2'),
              value: false,
              onChanged: (_) {},
            ),
            CheckboxListTile(
              title: const Text('Rocket 3'),
              value: false,
              onChanged: (_) {},
            ),
            CheckboxListTile(
              title: const Text('Rocket 4'),
              value: false,
              onChanged: (_) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('CANCEL'),
            onPressed: () {},
          ),
          TextButton(
            child: const Text('RESET'),
            onPressed: () {},
          ),
          TextButton(
            child: const Text('OK'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _DateChip extends StatelessWidget {
  const _DateChip({super.key});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: const Icon(Icons.date_range, size: _chipIconSize),
      label: const Text('Date Range'),
      onPressed: () => _handlePress(context),
    );
  }

  void _handlePress(BuildContext context) {
    final now = DateTime.now();
    final start = DateTime(2006);
    final end = DateTime(now.year + 2).subtract(const Duration(seconds: 1));
    showDateRangePicker(
      context: context,
      firstDate: start,
      lastDate: end,
      currentDate: now,
      initialEntryMode: DatePickerEntryMode.input,
      initialDateRange: DateTimeRange(start: start, end: end),
    );
  }
}

class _FlightNumberChip extends StatelessWidget {
  const _FlightNumberChip({super.key});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: const Icon(Icons.tag, size: _chipIconSize),
      label: const Text('Flight Number'),
      onPressed: () => _handlePress(context),
    );
  }

  void _handlePress(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Flight Number'),
        content: TextField(
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        actions: [
          TextButton(
            child: const Text('CANCEL'),
            onPressed: () {},
          ),
          TextButton(
            child: const Text('OK'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _SuccessfulnessChip extends StatelessWidget {
  const _SuccessfulnessChip({super.key});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: const Icon(Icons.done, size: _chipIconSize),
      label: const Text('Successfulness'),
      onPressed: () => _handlePress(context),
    );
  }

  void _handlePress(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Select Successfulness'),
        children: [
          SimpleDialogOption(
            child: const Text('All'),
            onPressed: () {},
          ),
          SimpleDialogOption(
            child: const Text('Success'),
            onPressed: () {},
          ),
          SimpleDialogOption(
            child: const Text('Failure'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
