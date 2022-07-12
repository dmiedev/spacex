import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  const authority = 'api.spacexdata.com';
  final companyUrl = Uri.https(authority, '/v4/company');
  final allRocketsUrl = Uri.https(authority, '/v4/rockets');
  final queryRocketsUrl = Uri.https(authority, '/v4/rockets/query');
  final queryLaunchesUrl = Uri.https(authority, '/v5/launches/query');

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

  group('SpacexApiClient', () {
    late SpacexApiClient spacexApiClient;
    late MockHttpClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
      spacexApiClient = SpacexApiClient(httpClient: mockHttpClient);
    });

    test('constructor returns normally', () {
      expect(SpacexApiClient.new, returnsNormally);
    });

    group('.fetchCompany()', () {
      test(
        'throws an HttpException when an exception '
        'from http.Client is thrown',
        () {
          when(() => mockHttpClient.get(companyUrl)).thenThrow(Exception());
          expect(
            () => spacexApiClient.fetchCompany(),
            throwsA(isA<HttpException>()),
          );
        },
      );

      test(
        'throws an HttpRequestException when response status code is not 200',
        () {
          const statusCode = 404;
          when(() => mockHttpClient.get(companyUrl)).thenAnswer(
            (_) async => http.Response('', statusCode),
          );
          expect(
            () => spacexApiClient.fetchCompany(),
            throwsA(
              isA<HttpRequestException>().having(
                (exception) => exception.statusCode,
                'HttpRequestException.statusCode',
                equals(statusCode),
              ),
            ),
          );
        },
      );

      test('throws a JsonDecodeException when json decoding fails', () {
        when(() => mockHttpClient.get(companyUrl)).thenAnswer(
          (_) async => http.Response('not a map', 200),
        );
        expect(
          () => spacexApiClient.fetchCompany(),
          throwsA(isA<JsonDecodeException>()),
        );
      });

      test(
        'returns a JsonDeserializationException when deserialization fails',
        () {
          when(() => mockHttpClient.get(companyUrl)).thenAnswer(
            (_) async => http.Response('{ "not": "a company" }', 200),
          );
          expect(
            () => spacexApiClient.fetchCompany(),
            throwsA(isA<JsonDeserializationException>()),
          );
        },
      );

      test('returns correct output when response body is valid', () {
        when(() => mockHttpClient.get(companyUrl)).thenAnswer(
          (_) async => http.Response(json.encode(company), 200),
        );
        expect(spacexApiClient.fetchCompany(), completion(equals(company)));
      });
    });

    group('.fetchAllRockets()', () {
      test(
        'throws an HttpException when an exception '
        'from http.Client is thrown',
        () {
          when(() => mockHttpClient.get(allRocketsUrl)).thenThrow(Exception());
          expect(
            () => spacexApiClient.fetchAllRockets(),
            throwsA(isA<HttpException>()),
          );
        },
      );

      test(
        'throws an HttpRequestException when response status code is not 200',
        () {
          const statusCode = 404;
          when(() => mockHttpClient.get(allRocketsUrl)).thenAnswer(
            (_) async => http.Response('', statusCode),
          );
          expect(
            () => spacexApiClient.fetchAllRockets(),
            throwsA(
              isA<HttpRequestException>().having(
                (exception) => exception.statusCode,
                'HttpRequestException.statusCode',
                equals(statusCode),
              ),
            ),
          );
        },
      );

      test('throws a JsonDecodeException when json decoding fails', () {
        when(() => mockHttpClient.get(allRocketsUrl)).thenAnswer(
          (_) async => http.Response('not a map', 200),
        );
        expect(
          () => spacexApiClient.fetchAllRockets(),
          throwsA(isA<JsonDecodeException>()),
        );
      });

      test(
        'returns a JsonDeserializationException when deserialization fails',
        () {
          when(() => mockHttpClient.get(allRocketsUrl)).thenAnswer(
            (_) async => http.Response(
              '[ { "rocket": false }, { "not a rocket": true } ]',
              200,
            ),
          );
          expect(
            () => spacexApiClient.fetchAllRockets(),
            throwsA(isA<JsonDeserializationException>()),
          );
        },
      );

      test('returns correct output when response body is valid', () {
        when(() => mockHttpClient.get(allRocketsUrl)).thenAnswer(
          (_) async => http.Response(json.encode(rockets), 200),
        );
        expect(spacexApiClient.fetchAllRockets(), completion(equals(rockets)));
      });
    });

    group('.queryRockets()', () {
      test('makes correct request', () {
        final filter = Filter.equal('country', 'USA');
        const options = PaginationOptions(select: ['name'], offset: 2, page: 3);
        final requestBody = {
          'query': filter.toJson(),
          'options': options.toJson(),
        };
        when(
          () => mockHttpClient.post(queryRocketsUrl, body: any(named: 'body')),
        ).thenAnswer(
          (_) async => http.Response(json.encode(rocketPage), 200),
        );
        spacexApiClient.queryRockets(filter: filter, options: options);
        verify(
          () => mockHttpClient.post(
            queryRocketsUrl,
            body: any(named: 'body', that: equals(requestBody)),
          ),
        ).called(1);
      });

      test(
        'throws an HttpException when an exception '
        'from http.Client is thrown',
        () {
          when(
            () => mockHttpClient.post(
              queryRocketsUrl,
              body: any(named: 'body'),
            ),
          ).thenThrow(Exception());
          expect(
            () => spacexApiClient.queryRockets(),
            throwsA(isA<HttpException>()),
          );
        },
      );

      test(
        'throws an HttpRequestException when response status code is not 200',
        () {
          const statusCode = 404;
          when(
            () => mockHttpClient.post(
              queryRocketsUrl,
              body: any(named: 'body'),
            ),
          ).thenAnswer((_) async => http.Response('', statusCode));
          expect(
            () => spacexApiClient.queryRockets(),
            throwsA(
              isA<HttpRequestException>().having(
                (exception) => exception.statusCode,
                'HttpRequestException.statusCode',
                equals(statusCode),
              ),
            ),
          );
        },
      );

      test('throws a JsonDecodeException when json decoding fails', () {
        when(
          () => mockHttpClient.post(queryRocketsUrl, body: any(named: 'body')),
        ).thenAnswer((_) async => http.Response('not a map', 200));
        expect(
          () => spacexApiClient.queryRockets(),
          throwsA(isA<JsonDecodeException>()),
        );
      });

      test(
        'returns a JsonDeserializationException when deserialization fails',
        () {
          when(
            () => mockHttpClient.post(
              queryRocketsUrl,
              body: any(named: 'body'),
            ),
          ).thenAnswer(
            (_) async => http.Response('{ "not_a_page": true }', 200),
          );
          expect(
            () => spacexApiClient.queryRockets(),
            throwsA(isA<JsonDeserializationException>()),
          );
        },
      );

      test('returns correct output when response body is valid', () {
        when(
          () => mockHttpClient.post(
            queryRocketsUrl,
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => http.Response(json.encode(rocketPage), 200));
        expect(spacexApiClient.queryRockets(), completion(equals(rocketPage)));
      });
    });

    group('.queryLaunches()', () {
      test('makes correct request', () {
        final filter = Filter.equal('name', 'CR-1');
        const options = PaginationOptions(select: ['success'], offset: 2);
        final requestBody = {
          'query': filter.toJson(),
          'options': options.toJson(),
        };
        when(
          () => mockHttpClient.post(queryLaunchesUrl, body: any(named: 'body')),
        ).thenAnswer(
          (_) async => http.Response(json.encode(launchPage), 200),
        );
        spacexApiClient.queryLaunches(filter: filter, options: options);
        verify(
          () => mockHttpClient.post(
            queryLaunchesUrl,
            body: any(named: 'body', that: equals(requestBody)),
          ),
        ).called(1);
      });

      test(
        'throws an HttpException when an exception '
        'from http.Client is thrown',
        () {
          when(
            () => mockHttpClient.post(
              queryLaunchesUrl,
              body: any(named: 'body'),
            ),
          ).thenThrow(Exception());
          expect(
            () => spacexApiClient.queryLaunches(),
            throwsA(isA<HttpException>()),
          );
        },
      );

      test(
        'throws an HttpRequestException when response status code is not 200',
        () {
          const statusCode = 404;
          when(
            () => mockHttpClient.post(
              queryLaunchesUrl,
              body: any(named: 'body'),
            ),
          ).thenAnswer((_) async => http.Response('', statusCode));
          expect(
            () => spacexApiClient.queryLaunches(),
            throwsA(
              isA<HttpRequestException>().having(
                (exception) => exception.statusCode,
                'HttpRequestException.statusCode',
                equals(statusCode),
              ),
            ),
          );
        },
      );

      test('throws a JsonDecodeException when json decoding fails', () {
        when(
          () => mockHttpClient.post(queryLaunchesUrl, body: any(named: 'body')),
        ).thenAnswer((_) async => http.Response('not a map', 200));
        expect(
          () => spacexApiClient.queryLaunches(),
          throwsA(isA<JsonDecodeException>()),
        );
      });

      test(
        'returns a JsonDeserializationException when deserialization fails',
        () {
          when(
            () => mockHttpClient.post(
              queryLaunchesUrl,
              body: any(named: 'body'),
            ),
          ).thenAnswer(
            (_) async => http.Response('{ "not_a_page": true }', 200),
          );
          expect(
            () => spacexApiClient.queryLaunches(),
            throwsA(isA<JsonDeserializationException>()),
          );
        },
      );

      test('returns correct output when response body is valid', () {
        when(
          () => mockHttpClient.post(
            queryLaunchesUrl,
            body: any(named: 'body'),
          ),
        ).thenAnswer((_) async => http.Response(json.encode(launchPage), 200));
        expect(spacexApiClient.queryLaunches(), completion(equals(launchPage)));
      });
    });
  });
}
