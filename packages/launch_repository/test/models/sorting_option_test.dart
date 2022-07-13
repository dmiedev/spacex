// ignore_for_file: prefer_const_constructors

import 'package:launch_repository/launch_repository.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:test/test.dart';

void main() {
  group('SortingOption', () {
    final option = SortingOption(
      feature: LaunchFeature.isSuccessful,
      order: SortOrder.descending,
    );

    test('supports value comparisons', () {
      expect(
        option,
        SortingOption(
          feature: LaunchFeature.isSuccessful,
          order: SortOrder.descending,
        ),
      );
    });
  });
}
