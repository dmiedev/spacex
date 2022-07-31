// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rocket_repository/rocket_repository.dart';
import 'package:spacex/l10n/l10n.dart';
import 'package:spacex/launch_filtering/bloc/bloc.dart';
import 'package:spacex_ui/spacex_ui.dart';

/// A launch filtering chip that displays a dialog to select rockets on
/// user press.
class LaunchRocketChip extends StatelessWidget {
  /// Creates a launch rocket filtering chip.
  const LaunchRocketChip({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaunchFilteringBloc, LaunchFilteringState>(
      buildWhen: (previous, current) =>
          previous.filtering.rocketIds != current.filtering.rocketIds,
      builder: (context, state) => FilteringChip(
        icon: const Icon(Icons.rocket),
        active: state.filtering.rocketIds.isNotEmpty,
        label: _getLabel(context, state.allRockets, state.filtering.rocketIds),
        onPressed: () => _handlePress(context),
      ),
    );
  }

  String _getLabel(
    BuildContext context,
    List<RocketInfo>? allRockets,
    List<String> rocketIds,
  ) {
    final l10n = context.l10n;
    if (rocketIds.isEmpty) {
      return l10n.rocketChipLabel;
    } else {
      return '${l10n.rocketChipLabel}: ${rocketIds.length}';
    }
  }

  void _handlePress(BuildContext context) {
    showDialog<RocketInfo>(
      context: context,
      builder: (newContext) => BlocProvider.value(
        value: context.read<LaunchFilteringBloc>(),
        child: const _RocketSelectionDialog(),
      ),
    );
  }
}

class _RocketSelectionDialog extends StatefulWidget {
  const _RocketSelectionDialog();

  @override
  State<_RocketSelectionDialog> createState() => _RocketSelectionDialogState();
}

class _RocketSelectionDialogState extends State<_RocketSelectionDialog> {
  late final List<bool> _rocketSelection;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<LaunchFilteringBloc>();
    if (bloc.state.allRocketsAreLoaded) {
      _initializeRocketSelection(
        bloc.state.allRockets!,
        bloc.state.filtering.rocketIds,
      );
    } else {
      bloc.add(const LaunchFilteringRocketsRequested());
    }
  }

  void _initializeRocketSelection(
    List<RocketInfo> rockets,
    List<String> selectedRocketIds,
  ) {
    _rocketSelection = List<bool>.generate(
      rockets.length,
      (index) => selectedRocketIds.contains(rockets[index].id),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<LaunchFilteringBloc, LaunchFilteringState>(
      listenWhen: (previous, current) =>
          !previous.allRocketsAreLoaded && current.allRocketsAreLoaded,
      listener: (context, state) => _initializeRocketSelection(
        state.allRockets!,
        state.filtering.rocketIds,
      ),
      buildWhen: (previous, current) =>
          previous.allRockets != current.allRockets,
      builder: (context, state) => AlertDialog(
        title: Text(l10n.rocketSelectionDialogTitle),
        content: _buildBody(context, state),
        actions: [
          TextButton(
            child: Text(l10n.cancelButtonLabel),
            onPressed: () => Navigator.pop(context),
          ),
          if (state.allRocketsAreLoaded)
            TextButton(
              child: Text(l10n.resetButtonLabel),
              onPressed: () => _saveAndPop(reset: true),
            ),
          if (state.allRocketsAreLoaded)
            TextButton(
              child: Text(l10n.okButtonLabel),
              onPressed: () => _saveAndPop(reset: false),
            ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, LaunchFilteringState state) {
    final l10n = context.l10n;
    if (state.allRockets == null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Center(child: CircularProgressIndicator()),
        ],
      );
    } else if (state.allRockets!.isEmpty) {
      return TextMessage(
        text: l10n.loadingErrorMessageTextShort,
        textMaxLines: 3,
        useAutoSizeText: false,
        button: IconTextButton(
          icon: const Icon(Icons.replay),
          label: l10n.retryButtonLabel,
          onPressed: _handleRetryButtonPress,
        ),
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int index = 0; index < state.allRockets!.length; index++)
          CheckboxListTile(
            title: Text(state.allRockets![index].name),
            value: _rocketSelection[index],
            onChanged: (value) => _handleSelection(index, value),
          ),
      ],
    );
  }

  void _handleRetryButtonPress() {
    context.read<LaunchFilteringBloc>().add(LaunchFilteringRocketsRequested());
  }

  void _handleSelection(int index, bool? value) {
    if (value != null) {
      setState(() => _rocketSelection[index] = value);
    }
  }

  void _saveAndPop({required bool reset}) {
    context.read<LaunchFilteringBloc>().add(
          LaunchFilteringRocketsSelected(
            rocketSelection: reset
                ? List.filled(_rocketSelection.length, false)
                : _rocketSelection,
          ),
        );
    Navigator.pop(context);
  }
}
