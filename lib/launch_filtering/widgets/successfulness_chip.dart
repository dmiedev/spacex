import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:spacex/l10n/l10n.dart';
import 'package:spacex/launch_filtering/bloc/bloc.dart';
import 'package:spacex_ui/spacex_ui.dart';

/// A launch filtering chip that displays a dialog to select launch
/// successfulness on user press.
class LaunchSuccessfulnessChip extends StatelessWidget {
  /// Creates a launch successfulness filtering chip.
  const LaunchSuccessfulnessChip({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaunchFilteringBloc, LaunchFilteringState>(
      buildWhen: (previous, current) =>
          previous.successfulness != current.successfulness ||
          previous.time != current.time,
      builder: (context, state) {
        if (state.time == LaunchTime.upcoming) {
          return Container();
        }
        return FilteringChip(
          active: state.successfulness != LaunchSuccessfulness.any,
          icon: Icon(
            state.successfulness == LaunchSuccessfulness.failure
                ? Icons.close
                : Icons.done,
          ),
          label: _getLabelText(context, state.successfulness),
          onPressed: () => _handlePress(context),
        );
      },
    );
  }

  String _getLabelText(
    BuildContext context,
    LaunchSuccessfulness successfulness,
  ) {
    final l10n = context.l10n;
    switch (successfulness) {
      case LaunchSuccessfulness.any:
        return l10n.successfulnessChipLabel;
      case LaunchSuccessfulness.success:
        return l10n.successSuccessfulnessChipLabel;
      case LaunchSuccessfulness.failure:
        return l10n.failureSuccessfulnessChipLabel;
    }
  }

  Future<void> _handlePress(BuildContext context) async {
    final launchFilteringBloc = context.read<LaunchFilteringBloc>();
    final successfulness = await showDialog<LaunchSuccessfulness>(
      context: context,
      builder: (context) => const _LaunchSuccessfulnessSelectionDialog(),
    );
    if (successfulness != null) {
      launchFilteringBloc.add(
        LaunchFilteringSuccessfulnessSelected(successfulness: successfulness),
      );
    }
  }
}

class _LaunchSuccessfulnessSelectionDialog extends StatelessWidget {
  const _LaunchSuccessfulnessSelectionDialog();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SimpleDialog(
      title: Text(l10n.successfulnessSelectionDialogTitle),
      children: [
        SimpleDialogOption(
          child: Text(l10n.anyOptionLabel),
          onPressed: () => Navigator.pop(
            context,
            LaunchSuccessfulness.any,
          ),
        ),
        SimpleDialogOption(
          child: Text(l10n.successOptionLabel),
          onPressed: () => Navigator.pop(
            context,
            LaunchSuccessfulness.success,
          ),
        ),
        SimpleDialogOption(
          child: Text(l10n.failureOptionLabel),
          onPressed: () => Navigator.pop(
            context,
            LaunchSuccessfulness.failure,
          ),
        ),
      ],
    );
  }
}
