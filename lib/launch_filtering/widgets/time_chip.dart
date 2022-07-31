import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:spacex/l10n/l10n.dart';
import 'package:spacex/launch_filtering/bloc/bloc.dart';
import 'package:spacex_ui/spacex_ui.dart';

/// A launch filtering chip that switches launch time on user press.
class LaunchTimeChip extends StatelessWidget {
  /// Creates a launch time filtering chip.
  const LaunchTimeChip({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<LaunchFilteringBloc, LaunchFilteringState>(
      buildWhen: (previous, current) =>
          previous.filtering.time != current.filtering.time,
      builder: (context, state) => FilteringChip(
        active: true,
        icon: Icon(
          state.filtering.time == LaunchTime.upcoming
              ? Icons.history_toggle_off
              : Icons.schedule,
        ),
        onPressed: () => _handlePress(context),
        label: state.filtering.time == LaunchTime.upcoming
            ? l10n.upcomingTimeChipLabel
            : l10n.pastTimeChipLabel,
      ),
    );
  }

  void _handlePress(BuildContext context) {
    context.read<LaunchFilteringBloc>().add(LaunchFilteringTimeSwitched());
  }
}
