import 'package:company_repository/company_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:test/test.dart';

class MockSpacexApiClient extends Mock implements SpacexApiClient {}

void main() {
  const company = Company(
    id: '32031-039123-102',
    name: 'SpaceY',
    founder: 'Elon Musk',
    founded: 1337,
    employees: 123,
    vehicles: 10,
    launchSites: 5,
    testSites: 0,
    ceo: 'CEO',
    cto: 'CTO',
    coo: 'COO',
    ctoPropulsion: 'CTO of Propulsion',
    valuation: 99999999,
    headquarters: CompanyEntityLocation(
      address: '123 Street Street',
      city: 'Quebec',
      state: 'Canada',
    ),
    links: CompanyLinks(
      elonTwitter: 'twitter',
      flickr: 'flickr',
      website: 'website',
      twitter: 'twitter 2',
    ),
    summary: 'Not So Boring Company',
  );

  group('CompanyRepository', () {
    late MockSpacexApiClient mockApiClient;
    late CompanyRepository repository;

    setUp(() {
      mockApiClient = MockSpacexApiClient();
      repository = CompanyRepository(spacexApiClient: mockApiClient);
    });

    test('constructor returns normally', () {
      expect(CompanyRepository.new, returnsNormally);
    });

    group('.fetchCompany()', () {
      setUp(() {
        when(
          () => mockApiClient.fetchCompany(),
        ).thenAnswer((_) async => company);
      });

      test('throws CompanyFetchingException when fetching fails', () {
        when(() => mockApiClient.fetchCompany()).thenThrow(Exception());
        expect(
          () => repository.fetchCompany(),
          throwsA(isA<CompanyFetchingException>()),
        );
      });

      test('returns correct result if there is no exception', () {
        expect(repository.fetchCompany(), completion(equals(company)));
      });

      test('makes correct request', () {
        repository.fetchCompany();
        verify(() => mockApiClient.fetchCompany()).called(1);
      });
    });
  });
}
