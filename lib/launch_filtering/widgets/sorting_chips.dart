import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:spacex/l10n/l10n.dart';
import 'package:spacex/launch_filtering/bloc/bloc.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:spacex_ui/spacex_ui.dart';

/// A launch filtering chip that switches sorting order on user press.
class LaunchSortingOrderChip extends StatelessWidget {
  /// Creates a launch sorting order chip.
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
          const LaunchFilteringSortingOrderSwitched(),
        );
  }
}

/// A launch filtering chip that displays a dialog to select a sorting option on
/// user press.
class LaunchSortingChip extends StatelessWidget {
  /// Creates a launch sorting chip.
  const LaunchSortingChip({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaunchFilteringBloc, LaunchFilteringState>(
      buildWhen: (previous, current) =>
          previous.sorting.parameter != current.sorting.parameter,
      builder: (context, state) => FilteringChip(
        active: true,
        label: _mapLaunchFeatureToLabel(context, state.sorting.parameter),
        onPressed: () => _handlePress(context),
      ),
    );
  }

  String _mapLaunchFeatureToLabel(
    BuildContext context,
    LaunchSortingParameter sorting,
  ) {
    final l10n = context.l10n;
    switch (sorting) {
      case LaunchSortingParameter.date:
        return l10n.dateSortingChipLabel;
      case LaunchSortingParameter.name:
        return l10n.nameSortingChipLabel;
      case LaunchSortingParameter.flightNumber:
        return l10n.flightNumberSortingChipLabel;
      default:
        break;
    }
    return l10n.sortingChipLabel;
  }

  Future<void> _handlePress(BuildContext context) async {
    final launchFilteringBloc = context.read<LaunchFilteringBloc>();
    final parameter = await showDialog<LaunchSortingParameter>(
      context: context,
      builder: (context) => const _LaunchSortingSelectionDialog(),
    );
    if (parameter != null) {
      launchFilteringBloc.add(
        LaunchFilteringSortingSelected(sortingParameter: parameter),
      );
    }
  }
}

class _LaunchSortingSelectionDialog extends StatelessWidget {
  const _LaunchSortingSelectionDialog();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SimpleDialog(
      title: Text(l10n.sortingSelectionDialogTitle),
      children: [
        SimpleDialogOption(
          child: Text(l10n.dateOptionLabel),
          onPressed: () => Navigator.pop(context, LaunchSortingParameter.date),
        ),
        SimpleDialogOption(
          child: Text(l10n.nameOptionLabel),
          onPressed: () => Navigator.pop(context, LaunchSortingParameter.name),
        ),
        SimpleDialogOption(
          child: Text(l10n.flightNumberOptionLabel),
          onPressed: () => Navigator.pop(
            context,
            LaunchSortingParameter.flightNumber,
          ),
        ),
      ],
    );
  }
}
