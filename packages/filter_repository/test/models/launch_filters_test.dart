// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:filter_repository/filter_repository.dart';
import 'package:test/test.dart';

void main() {
  final filters = LaunchFilters(
    time: LaunchTime.past,
    fromDate: DateTime(2017, 3, 4),
    toDate: DateTime(2018, 4, 6),
    flightNumber: 12,
    successfulness: LaunchSuccessfulness.failure,
    rocketIds: ['123', '234'],
  );

  group('LaunchFilters', () {
    test('supports value comparisons', () {
      expect(
        filters,
        LaunchFilters(
          time: LaunchTime.past,
          fromDate: DateTime(2017, 3, 4),
          toDate: DateTime(2018, 4, 6),
          flightNumber: 12,
          successfulness: LaunchSuccessfulness.failure,
          rocketIds: ['123', '234'],
        ),
      );
    });
  });
}
