// ignore_for_file: prefer_const_constructors

import 'package:spacex_api/spacex_api.dart';
import 'package:test/test.dart';

void main() {
  group('Filter', () {
    group('support value comparison -', () {
      test('simple filter', () {
        final filter = Filter.equal('test_field', 'test_value');
        expect(filter, Filter.equal('test_field', 'test_value'));
      });

      test('grouped filter', () {
        final filter1 = Filter.equal('test_key', 'test_value');
        final filter2 = Filter.in_('test_key', const ['test_value']);
        final filters = [filter1, filter2];
        final filter = Filter.and(filters);
        expect(filter, Filter.and(filters));
      });
    });

    group('has correctly set fields -', () {
      test('empty', () {
        const filter = Filter.empty();
        expect(filter.field, isNull);
        expect(filter.operator, isNull);
        expect(filter.value, <String, dynamic>{});
      });

      group('simple operator -', () {
        test('equal', () {
          const field = 'test_field';
          const value = 'test_value';
          final filter = Filter.equal(field, value);
          expect(filter.field, field);
          expect(filter.operator, FilterOperator.equal.toString());
          expect(filter.value, value);
        });

        test('greaterThan', () {
          const field = 'test_field';
          const value = 'test_value';
          final filter = Filter.greaterThan(field, value);
          expect(filter.field, field);
          expect(filter.operator, FilterOperator.greaterThan.toString());
          expect(filter.value, value);
        });

        test('greaterThanOrEqual', () {
          const field = 'test_field';
          const value = 'test_value';
          final filter = Filter.greaterThanOrEqual(field, value);
          expect(filter.field, field);
          expect(filter.operator, FilterOperator.greaterThanOrEqual.toString());
          expect(filter.value, value);
        });

        test('in', () {
          const field = 'test_field';
          const values = ['test_value', 'test_value'];
          final filter = Filter.in_(field, values);
          expect(filter.field, field);
          expect(filter.operator, FilterOperator.in_.toString());
          expect(filter.value, values);
        });

        test('lessThan', () {
          const field = 'test_field';
          const value = 'test_value';
          final filter = Filter.lessThan(field, value);
          expect(filter.field, field);
          expect(filter.operator, FilterOperator.lessThan.toString());
          expect(filter.value, value);
        });

        test('lessThanOrEqual', () {
          const field = 'test_field';
          const value = 'test_value';
          final filter = Filter.lessThanOrEqual(field, value);
          expect(filter.field, field);
          expect(filter.operator, FilterOperator.lessThanOrEqual.toString());
          expect(filter.value, value);
        });

        test('notEqual', () {
          const field = 'test_field';
          const value = 'test_value';
          final filter = Filter.notEqual(field, value);
          expect(filter.field, field);
          expect(filter.operator, FilterOperator.notEqual.toString());
          expect(filter.value, value);
        });

        test('notIn', () {
          const field = 'test_field';
          const values = ['test_value', 'test_value'];
          final filter = Filter.notIn(field, values);
          expect(filter.field, field);
          expect(filter.operator, FilterOperator.notIn.toString());
          expect(filter.value, values);
        });

        test('exists', () {
          const field = 'test_field';
          final filter = Filter.exists(field, exists: false);
          expect(filter.field, field);
          expect(filter.operator, FilterOperator.exists.toString());
          expect(filter.value, false);
        });
      });

      test('text', () {
        const parameters = TextFilterParameters(search: 'abc');
        final filter = Filter.text(parameters);
        expect(filter.field, isNull);
        expect(filter.operator, FilterOperator.text.toString());
        expect(filter.value, parameters);
      });

      test('custom', () {
        const operator = r'$customOperator';
        const field = 'test_field';
        const value = 'test_value';
        const filter =
            Filter.custom(operator: operator, value: value, field: field);
        expect(filter.field, field);
        expect(filter.operator, operator);
        expect(filter.value, value);
      });

      group('grouped operator -', () {
        final filter1 = Filter.equal('test_field', 'test_value');
        final filter2 = Filter.in_('test_field', const ['test_value']);
        final filters = [filter1, filter2];

        test('and', () {
          final filter = Filter.and(filters);
          expect(filter.field, isNull);
          expect(filter.operator, FilterOperator.and.toString());
          expect(filter.value, filters);
        });

        test('nor', () {
          final filter = Filter.nor(filters);
          expect(filter.field, isNull);
          expect(filter.operator, FilterOperator.nor.toString());
          expect(filter.value, filters);
        });

        test('or', () {
          final filter = Filter.or(filters);
          expect(filter.field, isNull);
          expect(filter.operator, FilterOperator.or.toString());
          expect(filter.value, filters);
        });
      });
    });

    group('.toJson() returns correct result - ', () {
      test('simple operator', () {
        final filter = Filter.equal('test_field', 'test_value');
        expect(
          filter.toJson(),
          {
            'test_field': {r'$eq': 'test_value'}
          },
        );
      });

      test('simple operator with date', () {
        final date = DateTime(2017, 9, 7, 17, 30);
        final filter = Filter.equal('test_field', date);
        expect(
          filter.toJson(),
          {
            'test_field': {r'$eq': date.toIso8601String()}
          },
        );
      });

      test('text operator', () {
        final filter = Filter.text(
          TextFilterParameters(
            search: 'abc',
            language: 'eng',
          ),
        );
        expect(
          filter.toJson(),
          {
            r'$text': {
              r'$search': 'abc',
              r'$language': 'eng',
              r'$caseSensitive': false,
              r'$diacriticSensitive': false,
            }
          },
        );
      });

      test('group operator', () {
        final filter1 = Filter.equal('test_field1', 'test_value');
        final filter2 = Filter.in_('test_field2', const ['test_value']);
        final filter = Filter.and([filter1, filter2]);
        expect(
          filter.toJson(),
          {
            r'$and': [
              {
                'test_field1': {r'$eq': 'test_value'},
              },
              {
                'test_field2': {
                  r'$in': ['test_value'],
                },
              },
            ],
          },
        );
      });

      test('empty', () {
        final filter = Filter.empty();
        expect(filter.toJson(), <String, dynamic>{});
      });

      test('custom with no operator', () {
        final filter = Filter.custom(value: 'test_value', field: 'test_field');
        expect(filter.toJson(), {'test_field': 'test_value'});
      });

      test('custom with no operator and no field', () {
        final unsupportedFilter = Filter.custom(value: 'value');
        expect(unsupportedFilter.toJson, throwsA(isA<UnsupportedError>()));

        final filter = Filter.custom(value: const {'a': 'b', 'c': 'd'});
        expect(filter.value, {'a': 'b', 'c': 'd'});
      });
    });
  });

  group('TextFilterParameters', () {
    final parameters = TextFilterParameters(
      search: 'abc',
      language: 'eng',
      diacriticSensitive: true,
      caseSensitive: true,
    );

    final json = {
      r'$search': 'abc',
      r'$language': 'eng',
      r'$caseSensitive': true,
      r'$diacriticSensitive': true,
    };

    test('supports value comparisons', () {
      expect(
        parameters,
        equals(
          TextFilterParameters(
            search: 'abc',
            language: 'eng',
            diacriticSensitive: true,
            caseSensitive: true,
          ),
        ),
      );
    });

    test('.toJson() returns correct result', () {
      expect(parameters.toJson(), equals(json));

      final parametersWithoutLanguage = TextFilterParameters(search: 'abc');
      expect(
        parametersWithoutLanguage.toJson().containsKey(r'$language'),
        false,
      );
    });

    test('.fromJson() returns correct result', () {
      expect(TextFilterParameters.fromJson(json), equals(parameters));
    });
  });
}
