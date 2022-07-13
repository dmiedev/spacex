// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:launch_repository/launch_repository.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:test/test.dart';

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
    final valueOption = FilteringOption.value(
      feature: LaunchFeature.isSuccessful,
      value: true,
    );
    final anyFromValuesOption = FilteringOption.anyFromValues(
      feature: LaunchFeature.capsuleId,
      values: ['id1', 'id2'],
    );
    final intervalOption = FilteringOption.interval(
      feature: LaunchFeature.date,
      interval: DateTimeInterval(
        from: DateTime(2017, 3, 2),
        to: DateTime(2018, 3, 31),
      ),
    );

    test('supports value comparisons', () {
      expect(
        valueOption,
        FilteringOption.value(
          feature: LaunchFeature.isSuccessful,
          value: true,
        ),
      );
      expect(
        anyFromValuesOption,
        FilteringOption.anyFromValues(
          feature: LaunchFeature.capsuleId,
          values: ['id1', 'id2'],
        ),
      );
      expect(
        intervalOption,
        FilteringOption.interval(
          feature: LaunchFeature.date,
          interval: DateTimeInterval(
            from: DateTime(2017, 3, 2),
            to: DateTime(2018, 3, 31),
          ),
        ),
      );
    });

    test('has correctly set fields', () {
      expect(valueOption.feature, LaunchFeature.isSuccessful);
      expect(valueOption.type, FilteringType.value);
      expect(valueOption.value, true);

      expect(anyFromValuesOption.feature, LaunchFeature.capsuleId);
      expect(anyFromValuesOption.type, FilteringType.anyFromValues);
      expect(anyFromValuesOption.value, ['id1', 'id2']);

      expect(intervalOption.feature, LaunchFeature.date);
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
        Filter.equal(LaunchFeature.isSuccessful.toFieldName(), true),
      );
      expect(
        anyFromValuesOption.toFilter(),
        Filter.in_(LaunchFeature.capsuleId.toFieldName(), ['id1', 'id2']),
      );
      expect(
        intervalOption.toFilter(),
        Filter.and([
          Filter.greaterThanOrEqual(
            LaunchFeature.date.toFieldName(),
            DateTime(2017, 3, 2),
          ),
          Filter.lessThanOrEqual(
            LaunchFeature.date.toFieldName(),
            DateTime(2018, 3, 31),
          ),
        ]),
      );
    });
  });
}
