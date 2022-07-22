import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex/launch_filtering/bloc/bloc.dart';
import 'package:spacex_ui/spacex_ui.dart';

class LaunchFlightNumberChip extends StatelessWidget {
  const LaunchFlightNumberChip({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaunchFilteringBloc, LaunchFilteringState>(
      buildWhen: (previous, current) =>
          previous.flightNumber != current.flightNumber,
      builder: (context, state) => FilteringChip(
        active: state.flightNumber != -1,
        icon: const Icon(Icons.tag),
        text: state.flightNumber != -1
            ? '${state.flightNumber}'
            : 'Flight Number',
        onPressed: () => _handlePress(context),
      ),
    );
  }

  Future<void> _handlePress(BuildContext context) async {
    final launchFilteringBloc = context.read<LaunchFilteringBloc>();
    final flightNumber = launchFilteringBloc.state.flightNumber;
    final newFlightNumber = await showDialog<int>(
      context: context,
      builder: (context) => _FlightNumberDialog(
        flightNumber: flightNumber != -1 ? flightNumber : null,
      ),
    );
    if (newFlightNumber != null) {
      launchFilteringBloc.add(
        LaunchFilteringFlightNumberSet(flightNumber: newFlightNumber),
      );
    }
  }
}

class _FlightNumberDialog extends StatefulWidget {
  const _FlightNumberDialog({
    super.key,
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
    return AlertDialog(
      title: const Text('Enter Flight Number'),
      content: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          validator: _validateFlightNumberField,
          controller: _textFieldController,
          keyboardType: TextInputType.number,
          maxLength: 3,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
            label: Text('Flight Number'),
            hintText: '123',
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('CANCEL'),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: const Text('RESET'),
          onPressed: () => Navigator.pop(context, -1),
        ),
        TextButton(
          child: const Text('OK'),
          onPressed: () => _handleOkButtonPress(context),
        ),
      ],
    );
  }

  String? _validateFlightNumberField(String? string) {
    if (string != null && string.isEmpty) {
      return 'This field must not be empty!';
    }
    return null;
  }

  void _handleOkButtonPress(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, int.parse(_textFieldController.text));
    }
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }
}
