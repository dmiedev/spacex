import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:spacex/l10n/l10n.dart';
import 'package:spacex/launch_filtering/bloc/bloc.dart';
import 'package:spacex_ui/spacex_ui.dart';

extension _DateTimeRangeConverter on DateTimeRange {
  DateTimeInterval toInterval() {
    return DateTimeInterval(from: start, to: end);
  }

  static DateTimeRange fromInterval(DateTimeInterval interval) {
    return DateTimeRange(start: interval.from, end: interval.to);
  }
}

/// A launch filtering chip that displays a launch year range selection dialog
/// on user press.
class LaunchYearRangeChip extends StatelessWidget {
  /// Creates a launch year range filtering chip.
  const LaunchYearRangeChip({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<LaunchFilteringBloc, LaunchFilteringState>(
      buildWhen: (previous, current) =>
          previous.filtering.dateInterval != current.filtering.dateInterval,
      builder: (context, state) => FilteringChip(
        active: state.filtering.dateInterval != null,
        icon: const Icon(Icons.date_range),
        label: state.filtering.dateInterval != null
            ? _getIntervalLabelText(state.filtering.dateInterval!)
            : l10n.yearRangeChipLabel,
        onPressed: () => _handlePress(context),
      ),
    );
  }

  String _getIntervalLabelText(DateTimeInterval interval) {
    if (interval.from.year == interval.to.year) {
      return '${interval.from.year}';
    } else {
      return '${interval.from.year}-${interval.to.year}';
    }
  }

  Future<void> _handlePress(BuildContext context) async {
    final launchFilteringBloc = context.read<LaunchFilteringBloc>();
    final currentInterval = launchFilteringBloc.state.filtering.dateInterval;

    final now = DateTime.now();
    final start = DateTime(2006);
    final end = DateTime(now.year + 2).subtract(const Duration(seconds: 1));

    final maxRange = DateTimeRange(start: start, end: end);

    final yearRange = await showDialog<DateTimeRange>(
      context: context,
      builder: (context) => YearRangePickerDialog(
        initialRange: currentInterval != null
            ? _DateTimeRangeConverter.fromInterval(currentInterval)
            : null,
        allowedRange: maxRange,
      ),
    );
    if (yearRange != null) {
      launchFilteringBloc.add(
        LaunchFilteringDateIntervalSet(
          dateInterval: yearRange == maxRange ? null : yearRange.toInterval(),
        ),
      );
    }
  }
}
