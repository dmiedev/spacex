import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex/l10n/l10n.dart';
import 'package:spacex/launch_filtering/bloc/bloc.dart';
import 'package:spacex_ui/spacex_ui.dart';

/// A chip that saves current launch filters on user click.
class LaunchFilterSaveChip extends StatelessWidget {
  /// Creates a chip that saves current launch filters on user click.
  const LaunchFilterSaveChip({super.key});

  @override
  Widget build(BuildContext context) {
    return FilteringChip(
      active: false,
      label: context.l10n.filterSaveChipLabel,
      onPressed: () => _handlePress(context),
    );
  }

  void _handlePress(BuildContext context) {
    context.read<LaunchFilteringBloc>().add(const LaunchFilteringSaved());
  }
}
