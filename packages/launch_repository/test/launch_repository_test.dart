import 'package:launch_repository/launch_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:test/test.dart';

class MockSpacexApiClient extends Mock implements SpacexApiClient {}

class FakeFilter extends Fake implements Filter {}

class FakePaginationOptions extends Fake implements PaginationOptions {}

void main() {
  final launches = List.generate(
    3,
    (index) => Launch(
      id: '$index',
      flightNumber: 111,
      name: 'CR-$index',
      dateUtc: DateTime(2017, 9, 7),
      dateLocal: DateTime(2017, 9, 6),
      datePrecision: DateTimePrecision.day,
      upcoming: false,
      staticFireDateUtc: DateTime(2017, 3, 4),
      window: 1,
      rocket: '1222',
      success: false,
      details: 'launch',
      launchLibraryId: '123321',
      links: const LaunchLinks(
        flickr: FlickrLaunchLinks(
          original: ['link 1'],
          small: ['link 2'],
        ),
      ),
    ),
  );

  final launchPage = Page<Launch>(
    docs: launches,
    totalDocs: 10,
    totalPages: 4,
    limit: 3,
    page: 1,
    offset: 0,
    pagingCounter: 1,
    hasNextPage: true,
    hasPrevPage: false,
    nextPage: 2,
  );

  group('LaunchRepository', () {
    late MockSpacexApiClient mockApiClient;
    late LaunchRepository repository;

    setUpAll(() {
      registerFallbackValue(FakeFilter());
      registerFallbackValue(FakePaginationOptions());
    });

    setUp(() {
      mockApiClient = MockSpacexApiClient();
      repository = LaunchRepository(spacexApiClient: mockApiClient);
    });

    test('constructor returns normally', () {
      expect(MockSpacexApiClient.new, returnsNormally);
    });

    test('throws RocketsFetchException on fetching fail', () {
      when(
        () => mockApiClient.queryLaunches(
          filter: any(named: 'filter'),
          options: any(named: 'options'),
        ),
      ).thenThrow(Exception());
      expect(
        repository.fetchLaunches(amount: 10, listNumber: 1),
        throwsA(isA<LaunchFetchingException>()),
      );
    });

    group('makes correct request -', () {
      setUp(() {
        when(
          () => mockApiClient.queryLaunches(
            filter: any(named: 'filter'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => launchPage);
      });

      test('simple fetching', () {
        repository.fetchLaunches(amount: 22, listNumber: 33);
        verify(
          () => mockApiClient.queryLaunches(
            filter: any(named: 'filter', that: equals(const Filter.empty())),
            options: any(
              named: 'options',
              that: equals(const PaginationOptions(limit: 22, page: 33)),
            ),
          ),
        ).called(1);
      });

      test('with sorting', () {
        repository.fetchLaunches(
          amount: 22,
          listNumber: 33,
          sorting: const SortingOption(
            feature: LaunchFeature.date,
            order: SortOrder.ascending,
          ),
        );
        verify(
          () => mockApiClient.queryLaunches(
            filter: any(named: 'filter', that: equals(const Filter.empty())),
            options: any(
              named: 'options',
              that: equals(
                const PaginationOptions(
                  limit: 22,
                  page: 33,
                  sort: {'date_utc': SortOrder.ascending},
                ),
              ),
            ),
          ),
        ).called(1);
      });

      test('with filtering', () {
        const option1 = FilteringOption.anyFromValues(
          feature: LaunchFeature.coreId,
          values: ['id1', 'id2'],
        );
        const option2 = FilteringOption.value(
          feature: LaunchFeature.isUpcoming,
          value: true,
        );
        final option3 = FilteringOption.interval(
          feature: LaunchFeature.date,
          interval: DateTimeInterval(
            from: DateTime(2017, 3, 2),
            to: DateTime(2018, 3, 31),
          ),
        );
        repository.fetchLaunches(
          amount: 22,
          listNumber: 33,
          filtering: [option1, option2, option3],
        );
        verify(
          () => mockApiClient.queryLaunches(
            filter: any(
              named: 'filter',
              that: equals(
                Filter.and([
                  option1.toFilter(),
                  option2.toFilter(),
                  option3.toFilter(),
                ]),
              ),
            ),
            options: any(
              named: 'options',
              that: equals(const PaginationOptions(limit: 22, page: 33)),
            ),
          ),
        ).called(1);
      });

      test('with text search', () {
        const option = FilteringOption.value(
          feature: LaunchFeature.isUpcoming,
          value: true,
        );
        repository.fetchLaunches(
          amount: 22,
          listNumber: 33,
          searchedText: 'abc',
          filtering: [option],
        );
        verify(
          () => mockApiClient.queryLaunches(
            filter: any(
              named: 'filter',
              that: equals(
                Filter.and([
                  option.toFilter(),
                  Filter.text(const TextFilterParameters(search: 'abc')),
                ]),
              ),
            ),
            options: any(
              named: 'options',
              that: equals(const PaginationOptions(limit: 22, page: 33)),
            ),
          ),
        );
      });
    });
  });
}
