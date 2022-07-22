import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex/launch_filtering/bloc/bloc.dart';
import 'package:spacex_ui/spacex_ui.dart';

class LaunchSuccessfulnessChip extends StatelessWidget {
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
          text: _getLabelText(state.successfulness),
          onPressed: () => _handlePress(context),
        );
      },
    );
  }

  String _getLabelText(LaunchSuccessfulness successfulness) {
    switch (successfulness) {
      case LaunchSuccessfulness.any:
        return 'Successfulness';
      case LaunchSuccessfulness.success:
        return 'Success';
      case LaunchSuccessfulness.failure:
        return 'Failure';
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
  const _LaunchSuccessfulnessSelectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Select Successfulness'),
      children: [
        SimpleDialogOption(
          child: const Text('Any'),
          onPressed: () => Navigator.pop(
            context,
            LaunchSuccessfulness.any,
          ),
        ),
        SimpleDialogOption(
          child: const Text('Success'),
          onPressed: () => Navigator.pop(
            context,
            LaunchSuccessfulness.success,
          ),
        ),
        SimpleDialogOption(
          child: const Text('Failure'),
          onPressed: () => Navigator.pop(
            context,
            LaunchSuccessfulness.failure,
          ),
        ),
      ],
    );
  }
}
