import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class YearRangePickerDialog extends StatefulWidget {
  const YearRangePickerDialog({
    super.key,
    this.initialRange,
    required this.allowedRange,
  });

  final DateTimeRange? initialRange;
  final DateTimeRange allowedRange;

  @override
  State<YearRangePickerDialog> createState() => _YearRangePickerDialogState();
}

class _YearRangePickerDialogState extends State<YearRangePickerDialog> {
  final _formKey = GlobalKey<FormState>();

  final _yearRangeStartController = TextEditingController();
  final _yearRangeEndController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialRange != null) {
      _yearRangeStartController.text = '${widget.initialRange!.start.year}';
      _yearRangeEndController.text = '${widget.initialRange!.end.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter Year Range'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              validator: _validateYearRangeStartField,
              controller: _yearRangeStartController,
              keyboardType: TextInputType.number,
              maxLength: 4,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                label: const Text('Start Year'),
                hintText: '${widget.allowedRange.start.year}',
              ),
            ),
            TextFormField(
              validator: _validateYearRangeEndField,
              controller: _yearRangeEndController,
              keyboardType: TextInputType.number,
              maxLength: 4,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                label: const Text('End Year'),
                hintText: '${widget.allowedRange.end.year}',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('CANCEL'),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: const Text('RESET'),
          onPressed: () => Navigator.pop(context, widget.allowedRange),
        ),
        TextButton(
          child: const Text('OK'),
          onPressed: () => _handleOkButtonPress(context),
        ),
      ],
    );
  }

  bool _checkFieldYearRangeCorrectness() {
    final startYear = int.parse(_yearRangeStartController.text);
    final endYear = int.parse(_yearRangeEndController.text);
    return startYear <= endYear;
  }

  String? _validateYearRangeField(String? string, String anotherFieldText) {
    final startLimit = widget.allowedRange.start.year;
    final endLimit = widget.allowedRange.end.year;
    if (string != null && string.isEmpty) {
      return 'This field must not be empty!';
    } else {
      final year = int.parse(string!);
      if (year < startLimit || year > endLimit) {
        return 'The year must be in the range $startLimit-$endLimit!';
      } else if (anotherFieldText.isNotEmpty) {
        if (!_checkFieldYearRangeCorrectness()) {
          return 'Incorrect range!';
        }
      }
    }
    return null;
  }

  String? _validateYearRangeStartField(String? string) {
    return _validateYearRangeField(string, _yearRangeEndController.text);
  }

  String? _validateYearRangeEndField(String? string) {
    return _validateYearRangeField(string, _yearRangeStartController.text);
  }

  void _handleOkButtonPress(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final startYear = int.parse(_yearRangeStartController.text);
      final endYear = int.parse(_yearRangeEndController.text);
      Navigator.pop(
        context,
        DateTimeRange(
          start: DateTime(startYear),
          end: DateTime(endYear + 1).subtract(const Duration(seconds: 1)),
        ),
      );
    }
  }
}
