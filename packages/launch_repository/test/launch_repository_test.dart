import 'package:flutter_test/flutter_test.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:local_settings_api/local_settings_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:spacex_api/spacex_api.dart';

class MockSpacexApiClient extends Mock implements SpacexApiClient {}

class MockLocalSettingsApi extends Mock implements LocalSettingsApi {}

class FakeFilter extends Fake implements Filter {}

class FakePaginationOptions extends Fake implements PaginationOptions {}

class FakeLaunchSorting extends Fake implements LaunchSorting {}

class FakeLaunchFiltering extends Fake implements LaunchFiltering {}

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

  final filtering = LaunchFiltering(
    dateInterval: DateTimeInterval(
      from: DateTime(2017, 3, 2),
      to: DateTime(2018, 3, 31),
    ),
    rocketIds: const ['id1', 'id2'],
  );

  const sorting = LaunchSorting(
    parameter: LaunchSortingParameter.date,
    order: SortOrder.ascending,
  );

  group('LaunchRepository', () {
    late MockSpacexApiClient mockApiClient;
    late MockLocalSettingsApi mockSettingApi;
    late LaunchRepository repository;

    setUpAll(() {
      registerFallbackValue(FakeFilter());
      registerFallbackValue(FakePaginationOptions());
      registerFallbackValue(FakeLaunchSorting());
      registerFallbackValue(FakeLaunchFiltering());
    });

    setUp(() {
      mockApiClient = MockSpacexApiClient();
      mockSettingApi = MockLocalSettingsApi();
      repository = LaunchRepository(
        spacexApiClient: mockApiClient,
        localSettingsApi: mockSettingApi,
      );
    });

    test('constructor returns normally', () {
      expect(MockSpacexApiClient.new, returnsNormally);
    });

    group('.fetchFiltered()', () {
      setUp(() {
        when(
          () => mockApiClient.queryLaunches(
            filter: any(named: 'filter'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => launchPage);
      });

      test('returns correct result if there is no exception', () {
        expect(
          repository.fetchFiltered(amount: 22, pageNumber: 33),
          completion(equals(launchPage.docs)),
        );
      });

      test('throws LaunchFetchingException on fetching fail', () {
        when(
          () => mockApiClient.queryLaunches(
            filter: any(named: 'filter'),
            options: any(named: 'options'),
          ),
        ).thenThrow(Exception());
        expect(
          repository.fetchFiltered(amount: 10, pageNumber: 1),
          throwsA(isA<LaunchFetchingException>()),
        );
      });

      group('makes correct request -', () {
        test('simple fetching', () {
          repository.fetchFiltered(amount: 22, pageNumber: 33);
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
          repository.fetchFiltered(
            amount: 22,
            pageNumber: 33,
            sorting: sorting,
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
          repository.fetchFiltered(
            amount: 22,
            pageNumber: 33,
            filtering: filtering,
          );
          verify(
            () => mockApiClient.queryLaunches(
              filter: any(
                named: 'filter',
                that: equals(Filter.and(filtering.toFilters())),
              ),
              options: any(
                named: 'options',
                that: equals(const PaginationOptions(limit: 22, page: 33)),
              ),
            ),
          ).called(1);
        });
      });
    });

    group('.loadSorting()', () {
      test('throws LaunchSortingException when loading fails', () {
        when(
          () => mockSettingApi.loadSetting<LaunchSorting>(
            name: any(named: 'name'),
            fromJson: any(named: 'fromJson'),
          ),
        ).thenThrow(Exception());
        expect(
          () => repository.loadSorting(),
          throwsA(isA<LaunchSortingException>()),
        );
      });

      test('makes correct request', () {
        when(
          () => mockSettingApi.loadSetting<LaunchSorting>(
            name: any(named: 'name'),
            fromJson: any(named: 'fromJson'),
          ),
        ).thenReturn(sorting);
        expect(repository.loadSorting(), sorting);
        verify(
          () => mockSettingApi.loadSetting<LaunchSorting>(
            name: any(named: 'name', that: equals('launch_sorting')),
            fromJson: any(
              named: 'fromJson',
              that: equals(LaunchSorting.fromJson),
            ),
          ),
        ).called(1);
      });
    });

    group('.saveSorting()', () {
      test('throws LaunchSortingException when loading fails', () {
        when(
          () => mockSettingApi.saveSetting<LaunchSorting>(
            name: any(named: 'name'),
            object: any(named: 'object'),
          ),
        ).thenThrow(Exception());
        expect(
          () => repository.saveSorting(sorting),
          throwsA(isA<LaunchSortingException>()),
        );
      });

      test('makes correct request', () {
        when(
          () => mockSettingApi.saveSetting<LaunchSorting>(
            name: any(named: 'name'),
            object: any(named: 'object'),
          ),
        ).thenAnswer((_) async {});
        repository.saveSorting(sorting);
        verify(
          () => mockSettingApi.saveSetting<LaunchSorting>(
            name: any(named: 'name', that: equals('launch_sorting')),
            object: any(named: 'object', that: equals(sorting)),
          ),
        ).called(1);
      });
    });

    group('.loadFiltering()', () {
      test('throws LaunchFilteringException when loading fails', () {
        when(
          () => mockSettingApi.loadSetting<LaunchFiltering>(
            name: any(named: 'name'),
            fromJson: any(named: 'fromJson'),
          ),
        ).thenThrow(Exception());
        expect(
          () => repository.loadFiltering(),
          throwsA(isA<LaunchFilteringException>()),
        );
      });

      test('makes correct request', () {
        when(
          () => mockSettingApi.loadSetting<LaunchFiltering>(
            name: any(named: 'name'),
            fromJson: any(named: 'fromJson'),
          ),
        ).thenReturn(filtering);
        expect(repository.loadFiltering(), filtering);
        verify(
          () => mockSettingApi.loadSetting<LaunchFiltering>(
            name: any(named: 'name', that: equals('launch_filtering')),
            fromJson: any(
              named: 'fromJson',
              that: equals(LaunchFiltering.fromJson),
            ),
          ),
        ).called(1);
      });
    });

    group('.saveFiltering()', () {
      test('throws LaunchFilteringException when loading fails', () {
        when(
          () => mockSettingApi.saveSetting<LaunchFiltering>(
            name: any(named: 'name'),
            object: any(named: 'object'),
          ),
        ).thenThrow(Exception());
        expect(
          () => repository.saveFiltering(filtering),
          throwsA(isA<LaunchFilteringException>()),
        );
      });

      test('makes correct request', () {
        when(
          () => mockSettingApi.saveSetting<LaunchFiltering>(
            name: any(named: 'name'),
            object: any(named: 'object'),
          ),
        ).thenAnswer((_) async {});
        repository.saveFiltering(filtering);
        verify(
          () => mockSettingApi.saveSetting<LaunchFiltering>(
            name: any(named: 'name', that: equals('launch_filtering')),
            object: any(named: 'object', that: equals(filtering)),
          ),
        ).called(1);
      });
    });
  });
}
