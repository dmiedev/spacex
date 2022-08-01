// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:spacex_api/spacex_api.dart';

void main() {
  final sorting = LaunchSorting(
    parameter: LaunchSortingParameter.date,
    order: SortOrder.ascending,
  );
  final json = {'parameter': 'date', 'order': 'ascending'};

  group('LaunchSorting', () {
    test('supports value comparisons', () {
      expect(
        sorting,
        LaunchSorting(
          parameter: LaunchSortingParameter.date,
          order: SortOrder.ascending,
        ),
      );
    });

    test('.toJson() returns correct result', () {
      expect(sorting.toJson(), isA<Map<String, dynamic>>());
    });

    test('.fromJson() returns correct result', () {
      expect(LaunchSorting.fromJson(json), sorting);
    });
  });
}
