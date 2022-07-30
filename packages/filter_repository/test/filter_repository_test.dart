import 'package:filter_repository/filter_repository.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockBox extends Mock implements LazyBox<Object> {}

void main() {
  final filters = LaunchFilters(
    time: LaunchTime.past,
    fromDate: DateTime(2017, 3, 4),
    toDate: DateTime(2018, 4, 6),
    flightNumber: 12,
    successfulness: LaunchSuccessfulness.failure,
    rocketIds: const ['123', '234'],
  );

  group('FilterRepository', () {
    late FilterRepository repository;
    late MockBox mockBox;

    setUp(() {
      mockBox = MockBox();
      repository = FilterRepository(box: mockBox);
    });

    test('constructor returns normally', () {
      expect(FilterRepository.new, returnsNormally);
    });

    group('.saveLaunchFilters()', () {
      test(
        'throws FilterRepositoryNotInitializedException if '
        'repository is not initialized',
        () {
          final repository = FilterRepository();
          expect(
            () => repository.saveLaunchFilters(filters),
            throwsA(isA<FilterRepositoryNotInitializedException>()),
          );
        },
      );

      test('throws FilterSaveLoadException when error occurs', () {
        when(() => mockBox.put(any<String>(), any())).thenThrow(Exception());
        expect(
          () => repository.saveLaunchFilters(filters),
          throwsA(isA<FilterSaveLoadException>()),
        );
      });

      test('makes correct request', () {
        when(() => mockBox.put(any<String>(), any())).thenAnswer((_) async {});
        repository.saveLaunchFilters(filters);
        verify(
          () => mockBox.put(
            any<String>(that: equals('launch')),
            any(that: equals(filters)),
          ),
        ).called(1);
      });
    });

    group('.getLaunchFilters()', () {
      test(
        'throws FilterRepositoryNotInitializedException if '
        'repository is not initialized',
        () {
          final repository = FilterRepository();
          expect(
            repository.getLaunchFilters,
            throwsA(isA<FilterRepositoryNotInitializedException>()),
          );
        },
      );

      test('throws FilterSaveLoadException when error occurs', () {
        when(() => mockBox.get(any<String>())).thenThrow(Exception());
        expect(
          () => repository.getLaunchFilters(),
          throwsA(isA<FilterSaveLoadException>()),
        );
      });

      test('makes correct request', () {
        when(() => mockBox.get(any<String>())).thenAnswer((_) async => filters);
        repository.getLaunchFilters();
        verify(
          () => mockBox.get(any<String>(that: equals('launch'))),
        ).called(1);
      });
    });
  });
}
