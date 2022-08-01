import 'package:mocktail/mocktail.dart';
import 'package:rocket_repository/rocket_repository.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:test/test.dart';

class MockSpacexApiClient extends Mock implements SpacexApiClient {}

class FakeFilter extends Fake implements Filter {}

class FakePaginationOptions extends Fake implements PaginationOptions {}

void main() {
  final rockets = List.generate(
    3,
    (index) => Rocket(
      id: '$index',
      name: 'Rocket #$index',
      active: true,
      stages: index,
      boosters: index,
      costPerLaunch: 333333,
      successRatePct: 99,
      firstFlight: DateTime(2017),
      country: 'USA',
      company: 'SpaceX',
      height: const Length(feet: 1, meters: 1),
      diameter: const Length(feet: 1, meters: 1),
      mass: const Mass(kg: 1, lb: 1),
      flickrImages: const ['link1', 'link2'],
      wikipedia: 'link',
      description: 'rocket',
    ),
  );

  final rocketPage = Page<Rocket>(
    docs: rockets,
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

  group('RocketRepository', () {
    late MockSpacexApiClient mockApiClient;
    late RocketRepository repository;

    setUpAll(() {
      registerFallbackValue(FakeFilter());
      registerFallbackValue(FakePaginationOptions());
    });

    setUp(() {
      mockApiClient = MockSpacexApiClient();
      repository = RocketRepository(spacexApiClient: mockApiClient);
    });

    test('constructor returns normally', () {
      expect(RocketRepository.new, returnsNormally);
    });

    group('.fetchAllRockets()', () {
      setUp(() {
        when(
          () => mockApiClient.fetchAllRockets(),
        ).thenAnswer((_) async => rockets);
      });

      test('throws RocketFetchingException when fetching fails', () {
        when(() => mockApiClient.fetchAllRockets()).thenThrow(Exception());
        expect(
          () => repository.fetchAllRockets(),
          throwsA(isA<RocketFetchingException>()),
        );
      });

      test('returns correct result if there is no exception', () {
        expect(repository.fetchAllRockets(), completion(equals(rockets)));
      });

      test('makes correct request', () {
        repository.fetchAllRockets();
        verify(() => mockApiClient.fetchAllRockets()).called(1);
      });
    });

    group('.fetchRocketInfos()', () {
      setUp(() {
        when(
          () => mockApiClient.queryRockets(
            filter: any(named: 'filter'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => rocketPage);
      });

      test('throws RocketFetchingException when fetching fails', () {
        when(
          () => mockApiClient.queryRockets(
            filter: any(named: 'filter'),
            options: any(named: 'options'),
          ),
        ).thenThrow(Exception());
        expect(
          () => repository.fetchRocketInfos(),
          throwsA(isA<RocketFetchingException>()),
        );
      });

      test('returns correct result when there is no exception', () {
        expect(
          repository.fetchRocketInfos(),
          completion(
            equals(
              rocketPage.docs.map(
                (rocket) => RocketInfo(id: rocket.id, name: rocket.name!),
              ),
            ),
          ),
        );
      });

      test('makes correct request', () {
        repository.fetchRocketInfos();
        verify(
          () => mockApiClient.queryRockets(
            filter: any(named: 'filter', that: equals(const Filter.empty())),
            options: any(
              named: 'options',
              that: equals(
                const PaginationOptions(select: ['name'], pagination: false),
              ),
            ),
          ),
        ).called(1);
      });
    });
  });
}
