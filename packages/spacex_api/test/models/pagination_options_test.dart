// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:spacex_api/spacex_api.dart';
import 'package:test/test.dart';

void main() {
  final options = PaginationOptions(
    select: ['a'],
    sort: {'id': SortOrder.ascending, 'name': SortOrder.descending},
    offset: 1,
    page: 2,
    limit: 15,
    pagination: true,
    populate: ['capsules'],
  );

  group('PaginationOptions', () {
    test('has no required parameters', () {
      expect(PaginationOptions.new, returnsNormally);
    });

    test('supports value comparisons', () {
      expect(
        options,
        equals(
          PaginationOptions(
            select: ['a'],
            sort: {'id': SortOrder.ascending, 'name': SortOrder.descending},
            offset: 1,
            page: 2,
            limit: 15,
            pagination: true,
            populate: ['capsules'],
          ),
        ),
      );
    });

    test('.fromJson() returns correct result', () {
      expect(
        PaginationOptions.fromJson(
          {
            'select': ['a', 'b'],
            'sort': {'id': 'ascending', 'date': 'descending'},
            'offset': 1,
            'page': 2,
            'limit': 15,
            'pagination': false,
            'populate': ['payloads'],
          },
        ),
        isA<PaginationOptions>(),
      );
    });

    test('.toJson() returns correct result', () {
      final optionsWithoutPagination = PaginationOptions(
        select: ['a'],
        sort: {'id': SortOrder.ascending, 'name': SortOrder.descending},
        offset: 1,
        page: 2,
        limit: 15,
        populate: ['capsules'],
      );
      final json = optionsWithoutPagination.toJson();
      expect(
        json,
        isA<Map<String, dynamic>>()
            .having(
              (json) => (json['sort'] as Map<String, dynamic>)['id'],
              'sort.values',
              equals('ascending'),
            )
            .having(
              (json) => (json['sort'] as Map<String, dynamic>)['name'],
              'sort.values',
              equals('descending'),
            ),
      );
      expect(json.containsKey(['pagination']), false);
    });
  });
}
