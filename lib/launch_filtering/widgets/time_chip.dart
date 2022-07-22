import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex/launch_filtering/bloc/bloc.dart';
import 'package:spacex_ui/spacex_ui.dart';

class LaunchTimeChip extends StatelessWidget {
  const LaunchTimeChip({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaunchFilteringBloc, LaunchFilteringState>(
      buildWhen: (previous, current) => previous.time != current.time,
      builder: (context, state) => FilteringChip(
        active: true,
        icon: Icon(
          state.time == LaunchTime.upcoming
              ? Icons.history_toggle_off
              : Icons.schedule,
        ),
        onPressed: () => _handlePress(context),
        text: state.time == LaunchTime.upcoming ? 'Upcoming' : 'Past',
      ),
    );
  }

  void _handlePress(BuildContext context) {
    context.read<LaunchFilteringBloc>().add(LaunchFilteringTimeSwitched());
  }
}
