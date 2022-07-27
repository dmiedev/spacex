import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex/l10n/l10n.dart';
import 'package:spacex/launch_filtering/bloc/bloc.dart';
import 'package:spacex_ui/spacex_ui.dart';

/// A launch filtering chip that displays a dialog to enter a flight number on
/// user press.
class LaunchFlightNumberChip extends StatelessWidget {
  /// Creates a launch flight number filtering chip.
  const LaunchFlightNumberChip({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<LaunchFilteringBloc, LaunchFilteringState>(
      buildWhen: (previous, current) =>
          previous.flightNumber != current.flightNumber,
      builder: (context, state) => FilteringChip(
        active: state.flightNumber != null,
        icon: const Icon(Icons.tag),
        label: state.flightNumber != null
            ? '${state.flightNumber}'
            : l10n.flightNumberChipLabel,
        onPressed: () => _handlePress(context),
      ),
    );
  }

  Future<void> _handlePress(BuildContext context) async {
    final launchFilteringBloc = context.read<LaunchFilteringBloc>();
    final flightNumber = launchFilteringBloc.state.flightNumber;
    final newFlightNumber = await showDialog<String>(
      context: context,
      builder: (context) => _FlightNumberDialog(flightNumber: flightNumber),
    );
    if (newFlightNumber == null) {
      return;
    }
    launchFilteringBloc.add(
      LaunchFilteringFlightNumberSet(
        flightNumber: int.tryParse(newFlightNumber),
      ),
    );
  }
}

/// Flight number dialog.
///
/// Pops a String with flight number if was entered, and an empty String if
/// reset button was pressed.
class _FlightNumberDialog extends StatefulWidget {
  const _FlightNumberDialog({
    this.flightNumber,
  }) : assert(
          flightNumber == null || flightNumber >= 0,
          'Flight number must be positive.',
        );

  final int? flightNumber;

  @override
  State<_FlightNumberDialog> createState() => _FlightNumberDialogState();
}

class _FlightNumberDialogState extends State<_FlightNumberDialog> {
  final _formKey = GlobalKey<FormState>();
  final _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.flightNumber != null) {
      _textFieldController.text = '${widget.flightNumber}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AlertDialog(
      title: Text(l10n.flightNumberDialogTitle),
      content: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          validator: (string) => _validateFlightNumberField(context, string),
          controller: _textFieldController,
          keyboardType: TextInputType.number,
          maxLength: 3,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            label: Text(l10n.flightNumberChipLabel),
            hintText: '123',
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text(l10n.cancelButtonLabel),
          onPressed: () => _handleCancelButtonPress(context),
        ),
        TextButton(
          child: Text(l10n.resetButtonLabel),
          onPressed: () => _handleResetButtonPress(context),
        ),
        TextButton(
          child: Text(l10n.okButtonLabel),
          onPressed: () => _handleOkButtonPress(context),
        ),
      ],
    );
  }

  String? _validateFlightNumberField(BuildContext context, String? string) {
    if (string != null && string.isEmpty) {
      return context.l10n.emptyFieldError;
    }
    return null;
  }

  void _handleCancelButtonPress(BuildContext context) {
    Navigator.pop(context);
  }

  void _handleResetButtonPress(BuildContext context) {
    Navigator.pop(context, '');
  }

  void _handleOkButtonPress(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, _textFieldController.text);
    }
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }
}
