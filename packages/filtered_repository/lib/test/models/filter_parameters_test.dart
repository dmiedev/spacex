// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:filtered_repository/filtered_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:test/test.dart';

class _MockFeature extends Mock implements Feature {}

void main() {
  final feature1 = _MockFeature();
  final feature2 = _MockFeature();
  final feature3 = _MockFeature();

  final parameters = FilterParameters<_MockFeature>(
    filtering: [
      FilteringOption.value(feature: feature1, value: true),
      FilteringOption.anyFromValues(feature: feature2, values: ['1', '2'])
    ],
    sorting: SortingOption(feature: feature3, order: SortOrder.descending),
    searchedPhrase: '1234567',
  );

  group('FilterParameters', () {
    test('supports value comparisons', () {
      expect(
        parameters,
        FilterParameters<_MockFeature>(
          filtering: [
            FilteringOption.value(feature: feature1, value: true),
            FilteringOption.anyFromValues(feature: feature2, values: ['1', '2'])
          ],
          sorting:
              SortingOption(feature: feature3, order: SortOrder.descending),
          searchedPhrase: '1234567',
        ),
      );
    });
  });
}
