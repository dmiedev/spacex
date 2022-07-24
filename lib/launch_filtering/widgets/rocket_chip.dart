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
      buildWhen: (previous, current) => previous.rockets != current.rockets,
      builder: (context, state) => FilteringChip(
        icon: const Icon(Icons.rocket),
        active: state.rockets.isNotEmpty,
        label: _getLabel(context, state.allRockets, state.rockets),
        onPressed: () => _handlePress(context),
      ),
    );
  }

  String _getLabel(
    BuildContext context,
    List<RocketInfo>? allRockets,
    List<int> rockets,
  ) {
    final l10n = context.l10n;
    if (rockets.isEmpty) {
      return l10n.rocketChipLabel;
    } else if (rockets.length == 1) {
      return allRockets![rockets.first].name;
    } else {
      return '${l10n.rocketChipLabel}: ${rockets.length}';
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
      _initializeRocketSelection(bloc.state.allRockets!, bloc.state.rockets);
    } else {
      bloc.add(LaunchFilteringRocketsRequested());
    }
  }

  void _initializeRocketSelection(
    List<RocketInfo> rockets,
    List<int> selectedIndices,
  ) {
    _rocketSelection = List<bool>.generate(
      rockets.length,
      selectedIndices.contains,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AlertDialog(
      title: Text(l10n.rocketSelectionDialogTitle),
      content: BlocConsumer<LaunchFilteringBloc, LaunchFilteringState>(
        listenWhen: (previous, current) =>
            !previous.allRocketsAreLoaded && current.allRocketsAreLoaded,
        listener: (context, state) =>
            _initializeRocketSelection(state.allRockets!, state.rockets),
        buildWhen: (previous, current) =>
            previous.allRockets != current.allRockets,
        builder: (context, state) {
          if (state.allRockets == null) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.allRockets!.isEmpty) {
            return TextMessage(
              text: l10n.loadingErrorMessageTextShort,
              textMaxLines: 3,
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
        },
      ),
      actions: [
        TextButton(
          child: Text(l10n.cancelButtonLabel),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: Text(l10n.resetButtonLabel),
          onPressed: () => _saveAndPop(reset: true),
        ),
        TextButton(
          child: Text(l10n.okButtonLabel),
          onPressed: () => _saveAndPop(reset: false),
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
    final List<int> selectedIndices;
    if (reset) {
      selectedIndices = [];
    } else {
      final indices = _rocketSelection.asMap().keys;
      selectedIndices =
          indices.where((index) => _rocketSelection[index]).toList();
    }
    context.read<LaunchFilteringBloc>().add(
          LaunchFilteringRocketsSelected(rockets: selectedIndices),
        );
    Navigator.pop(context);
  }
}
