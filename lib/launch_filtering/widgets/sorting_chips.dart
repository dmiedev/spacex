import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:spacex/launch_filtering/bloc/bloc.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:spacex_ui/spacex_ui.dart';

class LaunchSortingOrderChip extends StatelessWidget {
  const LaunchSortingOrderChip({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaunchFilteringBloc, LaunchFilteringState>(
      buildWhen: (previous, current) =>
          previous.sorting.order != current.sorting.order,
      builder: (context, state) => FilteringChip(
        active: true,
        icon: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationX(
            state.sorting.order == SortOrder.ascending ? math.pi : 0,
          ),
          child: const Icon(Icons.sort),
        ),
        onPressed: () => _handlePress(context),
        tooltip: 'Sorting order',
      ),
    );
  }

  void _handlePress(BuildContext context) {
    context.read<LaunchFilteringBloc>().add(
          LaunchFilteringSortingOrderSwitched(),
        );
  }
}

class LaunchSortingChip extends StatelessWidget {
  const LaunchSortingChip({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaunchFilteringBloc, LaunchFilteringState>(
      buildWhen: (previous, current) =>
          previous.sorting.feature != current.sorting.feature,
      builder: (context, state) => FilteringChip(
        active: true,
        text: _mapLaunchFeatureToLabel(state.sorting.feature),
        onPressed: () => _handlePress(context),
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
    final launchFilteringBloc = context.read<LaunchFilteringBloc>();
    final feature = await showDialog<LaunchFeature>(
      context: context,
      builder: (context) => const _LaunchSortingSelectionDialog(),
    );
    if (feature != null) {
      launchFilteringBloc.add(LaunchFilteringSortingSelected(feature: feature));
    }
  }
}

class _LaunchSortingSelectionDialog extends StatelessWidget {
  const _LaunchSortingSelectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
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
    );
  }
}
