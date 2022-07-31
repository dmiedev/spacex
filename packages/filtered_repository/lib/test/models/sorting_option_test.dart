// ignore_for_file: prefer_const_constructors

import 'package:filtered_repository/filtered_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:test/test.dart';

class _MockFeature extends Mock implements Feature {}

void main() {
  final feature = _MockFeature();

  group('SortingOption', () {
    final option = SortingOption(
      feature: feature,
      order: SortOrder.descending,
    );

    test('supports value comparisons', () {
      expect(
        option,
        SortingOption(
          feature: feature,
          order: SortOrder.descending,
        ),
      );
    });
  });
}
