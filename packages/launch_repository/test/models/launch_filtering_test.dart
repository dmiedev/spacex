// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter_test/flutter_test.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:spacex_api/spacex_api.dart';

void main() {
  final dateTimeInterval = DateTimeInterval(
    from: DateTime(2017, 3, 4),
    to: DateTime(2018, 3, 4),
  );

  final filtering = LaunchFiltering(
    searchedPhrase: 'rocket',
    time: LaunchTime.past,
    flightNumber: 123,
    dateInterval: dateTimeInterval,
    successfulness: LaunchSuccessfulness.failure,
    rocketIds: ['id1', 'id2'],
  );

  final json = {
    'searchedPhrase': 'rocket',
    'time': 'past',
    'flightNumber': 123,
    'dateInterval': dateTimeInterval.toJson(),
    'successfulness': 'failure',
    'rocketIds': ['id1', 'id2'],
  };

  group('LaunchFiltering', () {
    test('supports value comparisons', () {
      expect(
        filtering,
        LaunchFiltering(
          searchedPhrase: 'rocket',
          time: LaunchTime.past,
          flightNumber: 123,
          dateInterval: DateTimeInterval(
            from: DateTime(2017, 3, 4),
            to: DateTime(2018, 3, 4),
          ),
          successfulness: LaunchSuccessfulness.failure,
          rocketIds: ['id1', 'id2'],
        ),
      );
    });

    test('.toJson() returns correct result', () {
      expect(
        filtering.toJson(),
        isA<Map<String, dynamic>>().having(
          (json) => json['dateInterval'],
          'dateInterval',
          dateTimeInterval.toJson(),
        ),
      );
    });

    test('.fromJson() returns correct result', () {
      expect(LaunchFiltering.fromJson(json), filtering);
    });

    test('.toFilters() returns correct result', () {
      expect(
        filtering.toFilters(),
        [
          Filter.text(const TextFilterParameters(search: '"rocket"')),
          Filter.equal('upcoming', false),
          Filter.equal('flight_number', 123),
          Filter.and([
            Filter.greaterThanOrEqual('date_utc', dateTimeInterval.from),
            Filter.lessThanOrEqual('date_utc', dateTimeInterval.to),
          ]),
          Filter.equal('success', false),
          Filter.in_('rocket', ['id1', 'id2']),
        ],
      );
      expect(
        const LaunchFiltering(successfulness: LaunchSuccessfulness.success)
            .toFilters(),
        [Filter.equal('upcoming', true)],
      );
    });
  });
}
