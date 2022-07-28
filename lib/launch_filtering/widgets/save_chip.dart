import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex/launch_filtering/bloc/bloc.dart';
import 'package:spacex_ui/spacex_ui.dart';

class LaunchFilterSaveChip extends StatelessWidget {
  const LaunchFilterSaveChip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilteringChip(
      active: false,
      label: 'Save filters',
      onPressed: () => _handlePress(context),
    );
  }

  void _handlePress(BuildContext context) {
    context.read<LaunchFilteringBloc>().add(LaunchFilteringSaved());
  }
}
