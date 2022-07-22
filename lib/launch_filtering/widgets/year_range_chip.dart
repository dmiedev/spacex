import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launch_repository/launch_repository.dart';
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

class LaunchYearRangeChip extends StatelessWidget {
  const LaunchYearRangeChip({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaunchFilteringBloc, LaunchFilteringState>(
      buildWhen: (previous, current) =>
          previous.dateInterval != current.dateInterval,
      builder: (context, state) => FilteringChip(
        active: state.dateInterval != null,
        icon: const Icon(Icons.date_range),
        text: state.dateInterval != null
            ? _getIntervalLabelText(state.dateInterval!)
            : 'Year Range',
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
    final currentInterval = launchFilteringBloc.state.dateInterval;

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
