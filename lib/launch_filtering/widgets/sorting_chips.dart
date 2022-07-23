import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:spacex/l10n/l10n.dart';
import 'package:spacex/launch_filtering/bloc/bloc.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:spacex_ui/spacex_ui.dart';

class LaunchSortingOrderChip extends StatelessWidget {
  const LaunchSortingOrderChip({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
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
        tooltip: l10n.sortingOrderChipTooltip,
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
        label: _mapLaunchFeatureToLabel(context, state.sorting.feature),
        onPressed: () => _handlePress(context),
      ),
    );
  }

  String _mapLaunchFeatureToLabel(BuildContext context, LaunchFeature feature) {
    final l10n = context.l10n;
    switch (feature) {
      case LaunchFeature.date:
        return l10n.dateSortingChipLabel;
      case LaunchFeature.name:
        return l10n.nameSortingChipLabel;
      case LaunchFeature.flightNumber:
        return l10n.flightNumberSortingChipLabel;
      // ignore: no_default_cases
      default:
        break;
    }
    return l10n.sortingChipLabel;
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
    final l10n = context.l10n;
    return SimpleDialog(
      title: Text(l10n.sortingSelectionDialogTitle),
      children: [
        SimpleDialogOption(
          child: Text(l10n.dateOptionLabel),
          onPressed: () => Navigator.pop(context, LaunchFeature.date),
        ),
        SimpleDialogOption(
          child: Text(l10n.nameOptionLabel),
          onPressed: () => Navigator.pop(context, LaunchFeature.name),
        ),
        SimpleDialogOption(
          child: Text(l10n.flightNumberOptionLabel),
          onPressed: () => Navigator.pop(context, LaunchFeature.flightNumber),
        ),
      ],
    );
  }
}
