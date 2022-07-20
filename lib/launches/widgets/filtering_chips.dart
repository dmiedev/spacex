import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:spacex/launches/bloc/bloc.dart';
import 'package:spacex_api/spacex_api.dart';

const _chipIconSize = 20.0;

class FilteringChips extends StatelessWidget {
  const FilteringChips({super.key});

  @override
  Widget build(BuildContext context) {
    const padding = SizedBox(width: 10);

    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        const _SortingOrderChip(),
        padding,
        const _SortingChip(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: VerticalDivider(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
          ),
        ),
        const _TimeChip(),
        padding,
        const _RocketChip(),
        padding,
        const _DateChip(),
        padding,
        const _FlightNumberChip(),
        padding,
        const _SuccessfulnessChip(),
      ],
    );
  }
}

class _SortingOrderChip extends StatelessWidget {
  const _SortingOrderChip({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaunchBloc, LaunchState>(
      buildWhen: (previous, current) =>
          previous.sorting.order != current.sorting.order,
      builder: (context, state) => ActionChip(
        label: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationX(
            state.sorting.order == SortOrder.ascending ? math.pi : 0,
          ),
          child: const Icon(Icons.sort, size: _chipIconSize),
        ),
        tooltip: 'Sorting order',
        onPressed: () => _handlePress(context),
      ),
    );
  }

  void _handlePress(BuildContext context) {
    context.read<LaunchBloc>().add(LaunchSortingOrderSwitched());
  }
}

class _SortingChip extends StatelessWidget {
  const _SortingChip({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaunchBloc, LaunchState>(
      buildWhen: (previous, current) =>
          previous.sorting.feature != current.sorting.feature,
      builder: (context, state) => ActionChip(
        label: Text(
          _mapLaunchFeatureToLabel(state.sorting.feature),
          style: const TextStyle(color: Colors.black),
        ),
        onPressed: () => _handlePress(context),
        backgroundColor: Colors.white,
      ),
    );
  }

  String _mapLaunchFeatureToLabel(LaunchFeature feature) {
    switch (feature) {
      case LaunchFeature.date:
        return 'Sorting by Date';
      case LaunchFeature.name:
        return 'Sorting by Name';
      case LaunchFeature.flightNumber:
        return 'Sorting by Flight Number';
      // ignore: no_default_cases
      default:
        break;
    }
    return 'Sorting';
  }

  Future<void> _handlePress(BuildContext context) async {
    final launchBloc = context.read<LaunchBloc>();
    final feature = await showDialog<LaunchFeature>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Select Sorting'),
        children: [
          SimpleDialogOption(
            child: const Text('Date'),
            onPressed: () => Navigator.pop(context, LaunchFeature.date),
          ),
          SimpleDialogOption(
            child: const Text('Name'),
            onPressed: () => Navigator.pop(context, LaunchFeature.name),
          ),
          SimpleDialogOption(
            child: const Text('Flight Number'),
            onPressed: () => Navigator.pop(context, LaunchFeature.flightNumber),
          ),
        ],
      ),
    );
    if (feature != null) {
      launchBloc.add(LaunchSortingSelected(feature: feature));
    }
  }
}

class _TimeChip extends StatelessWidget {
  const _TimeChip({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaunchBloc, LaunchState>(
      buildWhen: (previous, current) => previous.time != current.time,
      builder: (context, state) => ActionChip(
        avatar: Icon(
          state.time == LaunchTime.upcoming
              ? Icons.history_toggle_off
              : Icons.schedule,
          color: Colors.black,
          size: _chipIconSize,
        ),
        label: Text(
          state.time == LaunchTime.upcoming ? 'Upcoming' : 'Past',
          style: const TextStyle(color: Colors.black),
        ),
        onPressed: () => _handlePress(context),
        backgroundColor: Colors.white,
      ),
    );
  }

  void _handlePress(BuildContext context) {
    context.read<LaunchBloc>().add(LaunchTimeSwitched());
  }
}

class _RocketChip extends StatelessWidget {
  const _RocketChip({super.key});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: const Icon(Icons.rocket, size: _chipIconSize),
      label: const Text('Rocket'),
      onPressed: () => _handlePress(context),
    );
  }

  void _handlePress(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Sorting'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CheckboxListTile(
              title: const Text('Rocket 1'),
              value: false,
              onChanged: (_) {},
            ),
            CheckboxListTile(
              title: const Text('Rocket 2'),
              value: false,
              onChanged: (_) {},
            ),
            CheckboxListTile(
              title: const Text('Rocket 3'),
              value: false,
              onChanged: (_) {},
            ),
            CheckboxListTile(
              title: const Text('Rocket 4'),
              value: false,
              onChanged: (_) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('CANCEL'),
            onPressed: () {},
          ),
          TextButton(
            child: const Text('RESET'),
            onPressed: () {},
          ),
          TextButton(
            child: const Text('OK'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _DateChip extends StatelessWidget {
  const _DateChip({super.key});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: const Icon(Icons.date_range, size: _chipIconSize),
      label: const Text('Date Range'),
      onPressed: () => _handlePress(context),
    );
  }

  void _handlePress(BuildContext context) {
    final now = DateTime.now();
    final start = DateTime(2006);
    final end = DateTime(now.year + 2).subtract(const Duration(seconds: 1));
    showDateRangePicker(
      context: context,
      firstDate: start,
      lastDate: end,
      currentDate: now,
      initialEntryMode: DatePickerEntryMode.input,
      initialDateRange: DateTimeRange(start: start, end: end),
    );
  }
}

class _FlightNumberChip extends StatelessWidget {
  const _FlightNumberChip({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaunchBloc, LaunchState>(
      buildWhen: (previous, current) =>
          previous.flightNumber != current.flightNumber,
      builder: (context, state) => ActionChip(
        avatar: Icon(
          Icons.tag,
          size: _chipIconSize,
          color: state.flightNumber != -1 ? Colors.black : null,
        ),
        label: state.flightNumber != -1
            ? Text(
                '${state.flightNumber}',
                style: const TextStyle(color: Colors.black),
              )
            : const Text('Flight Number'),
        onPressed: () => _handlePress(context),
        backgroundColor: state.flightNumber != -1 ? Colors.white : null,
      ),
    );
  }

  Future<void> _handlePress(BuildContext context) async {
    final launchBloc = context.read<LaunchBloc>();
    final flightNumber = launchBloc.state.flightNumber;
    final newFlightNumber = await showDialog<int>(
      context: context,
      builder: (context) => _FlightNumberDialog(
        flightNumber: flightNumber != -1 ? flightNumber : null,
      ),
    );
    if (newFlightNumber != null) {
      launchBloc.add(LaunchFlightNumberSet(flightNumber: newFlightNumber));
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

class _SuccessfulnessChip extends StatelessWidget {
  const _SuccessfulnessChip({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaunchBloc, LaunchState>(
      buildWhen: (previous, current) =>
          previous.successfulness != current.successfulness ||
          previous.time != current.time,
      builder: (context, state) {
        if (state.time == LaunchTime.upcoming) {
          return Container();
        }
        return ActionChip(
          avatar: Icon(
            state.successfulness == LaunchSuccessfulness.failure
                ? Icons.close
                : Icons.done,
            size: _chipIconSize,
            color: state.successfulness == LaunchSuccessfulness.any
                ? null
                : Colors.black,
          ),
          label: Text(
            _getLabelText(state.successfulness),
            style: TextStyle(
              color: state.successfulness == LaunchSuccessfulness.any
                  ? null
                  : Colors.black,
            ),
          ),
          onPressed: () => _handlePress(context),
          backgroundColor: state.successfulness == LaunchSuccessfulness.any
              ? null
              : Colors.white,
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
    final launchBloc = context.read<LaunchBloc>();
    final successfulness = await showDialog<LaunchSuccessfulness>(
      context: context,
      builder: (context) => SimpleDialog(
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
      ),
    );
    if (successfulness != null) {
      launchBloc.add(
        LaunchSuccessfulnessSelected(successfulness: successfulness),
      );
    }
  }
}
