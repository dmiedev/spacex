// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:filtered_repository/filtered_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:test/test.dart';

class _MockFeature extends Mock implements Feature {}

void main() {
  final interval = DateTimeInterval(
    from: DateTime(2017, 3, 2),
    to: DateTime(2018, 3, 31),
  );

  group('DateTimeInterval', () {
    test('supports value comparisons', () {
      expect(
        interval,
        DateTimeInterval(
          from: DateTime(2017, 3, 2),
          to: DateTime(2018, 3, 31),
        ),
      );
    });
  });

  group('FilteringOption', () {
    final valueFeature = _MockFeature();
    final anyFromValuesFeature = _MockFeature();
    final intervalFeature = _MockFeature();

    when(valueFeature.toFieldName).thenReturn('value_feature');
    when(anyFromValuesFeature.toFieldName)
        .thenReturn('any_from_values_feature');
    when(intervalFeature.toFieldName).thenReturn('interval_feature');

    final valueOption = FilteringOption.value(
      feature: valueFeature,
      value: true,
    );
    final anyFromValuesOption = FilteringOption.anyFromValues(
      feature: anyFromValuesFeature,
      values: ['id1', 'id2'],
    );
    final intervalOption = FilteringOption.interval(
      feature: intervalFeature,
      interval: DateTimeInterval(
        from: DateTime(2017, 3, 2),
        to: DateTime(2018, 3, 31),
      ),
    );

    test('supports value comparisons', () {
      expect(
        valueOption,
        FilteringOption.value(feature: valueFeature, value: true),
      );
      expect(
        anyFromValuesOption,
        FilteringOption.anyFromValues(
          feature: anyFromValuesFeature,
          values: ['id1', 'id2'],
        ),
      );
      expect(
        intervalOption,
        FilteringOption.interval(
          feature: intervalFeature,
          interval: DateTimeInterval(
            from: DateTime(2017, 3, 2),
            to: DateTime(2018, 3, 31),
          ),
        ),
      );
    });

    test('has correctly set fields', () {
      expect(valueOption.feature, valueFeature);
      expect(valueOption.type, FilteringType.value);
      expect(valueOption.value, true);

      expect(anyFromValuesOption.feature, anyFromValuesFeature);
      expect(anyFromValuesOption.type, FilteringType.anyFromValues);
      expect(anyFromValuesOption.value, ['id1', 'id2']);

      expect(intervalOption.feature, intervalFeature);
      expect(intervalOption.type, FilteringType.dateTimeInterval);
      expect(
        intervalOption.value,
        DateTimeInterval(
          from: DateTime(2017, 3, 2),
          to: DateTime(2018, 3, 31),
        ),
      );
    });

    test('.toFilter() returns correct result', () {
      expect(
        valueOption.toFilter(),
        Filter.equal('value_feature', true),
      );
      expect(
        anyFromValuesOption.toFilter(),
        Filter.in_('any_from_values_feature', ['id1', 'id2']),
      );
      expect(
        intervalOption.toFilter(),
        Filter.and([
          Filter.greaterThanOrEqual('interval_feature', DateTime(2017, 3, 2)),
          Filter.lessThanOrEqual('interval_feature', DateTime(2018, 3, 31)),
        ]),
      );
    });
  });
}
