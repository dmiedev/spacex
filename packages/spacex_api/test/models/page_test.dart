// ignore_for_file: prefer_const_constructors
// ignore_for_file: inference_failure_on_collection_literal
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:json_annotation/json_annotation.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:test/test.dart';

void main() {
  final rocketPage = Page<Rocket>(
    docs: [
      Rocket(
        id: '123',
        name: 'Rocky',
        active: true,
        stages: 2,
        boosters: 5,
        costPerLaunch: 3000000,
        successRatePct: 95,
        firstFlight: DateTime(2012, 3, 5),
        country: 'USA',
        company: 'SpaceX',
        height: Length(feet: 120, meters: 36.576),
        diameter: Length(feet: 9.84251969, meters: 3),
        mass: Mass(kg: 100, lb: 220),
        flickrImages: ['image_link1', 'image_link2'],
        wikipedia: 'https://wikipedia.org/url',
        description: 'Powerful rocket.',
      ),
    ],
    totalDocs: 100,
    offset: 0,
    limit: 1,
    totalPages: 100,
    page: 1,
    pagingCounter: 1,
    hasPrevPage: false,
    hasNextPage: true,
    nextPage: 2,
  );

  final launchPage = Page<Launch>(
    docs: [
      Launch(
        id: '123',
        flightNumber: 111,
        name: 'CR-123',
        dateUtc: DateTime(2017, 9, 7),
        dateLocal: DateTime(2017, 9, 6),
        datePrecision: DateTimePrecision.day,
        upcoming: false,
        staticFireDateUtc: DateTime(2017, 3, 4),
        window: 1,
        rocket: '1222',
        success: false,
        details: 'launch',
        crew: [LaunchCrewMember(crew: '1', role: 'Captain')],
        ships: ['1010101010'],
        payloads: ['asdf2', 'asdf1'],
        capsules: ['123', '321'],
        launchpad: '654321',
        launchLibraryId: '123321',
        links: LaunchLinks(
          flickr: FlickrLaunchLinks(original: ['link 1'], small: ['link 2']),
        ),
        failures: [
          LaunchFailure(time: 123, reason: 'failure reason'),
        ],
        fairings: LaunchFairingsRecovery(recoveryAttempt: true),
        cores: [
          LaunchCore(core: 'abc', reused: true, landingType: 'ABC'),
        ],
      ),
    ],
    totalDocs: 100,
    offset: 0,
    limit: 1,
    totalPages: 100,
    page: 1,
    pagingCounter: 1,
    hasPrevPage: false,
    hasNextPage: true,
    nextPage: 2,
  );

  final unsupportedPage = Page<Company>(
    docs: [
      Company(
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
      ),
    ],
    totalDocs: 100,
    offset: 0,
    limit: 1,
    totalPages: 100,
    page: 1,
    pagingCounter: 1,
    hasPrevPage: false,
    hasNextPage: true,
    nextPage: 2,
  );

  group('Page', () {
    test('supports value comparisons', () {
      expect(
        rocketPage,
        equals(
          Page<Rocket>(
            docs: [
              Rocket(
                id: '123',
                name: 'Rocky',
                active: true,
                stages: 2,
                boosters: 5,
                costPerLaunch: 3000000,
                successRatePct: 95,
                firstFlight: DateTime(2012, 3, 5),
                country: 'USA',
                company: 'SpaceX',
                height: Length(feet: 120, meters: 36.576),
                diameter: Length(feet: 9.84251969, meters: 3),
                mass: Mass(kg: 100, lb: 220),
                flickrImages: ['image_link1', 'image_link2'],
                wikipedia: 'https://wikipedia.org/url',
                description: 'Powerful rocket.',
              ),
            ],
            totalDocs: 100,
            offset: 0,
            limit: 1,
            totalPages: 100,
            page: 1,
            pagingCounter: 1,
            hasPrevPage: false,
            hasNextPage: true,
            nextPage: 2,
          ),
        ),
      );
    });

    test(
      '.toJson() returns correct result for Launch and Rocket generic types',
      () {
        expect(
          rocketPage.toJson(),
          isA<Map<String, dynamic>>().having(
            (json) => json['docs'],
            'docs',
            isA<List<Map<String, dynamic>>>(),
          ),
        );
        expect(
          launchPage.toJson(),
          isA<Map<String, dynamic>>().having(
            (json) => json['docs'],
            'docs',
            isA<List<Map<String, dynamic>>>(),
          ),
        );
        expect(
          unsupportedPage.toJson,
          throwsA(isA<UnsupportedError>()),
        );
      },
    );

    test(
      '.fromJson() returns correct result for Launch and Rocket generic types',
      () {
        expect(
          Page.fromJson<Launch>(
            {
              'docs': [
                {
                  'fairings': {
                    'reused': false,
                    'recovery_attempt': false,
                    'recovered': false,
                    'ships': []
                  },
                  'links': {
                    'patch': {
                      'small':
                          'https://images2.imgbox.com/3c/0e/T8iJcSN3_o.png',
                      'large': 'https://images2.imgbox.com/40/e3/GypSkayF_o.png'
                    },
                    'reddit': {
                      'campaign': null,
                      'launch': null,
                      'media': null,
                      'recovery': null
                    },
                    'flickr': {'small': [], 'original': []},
                    'presskit': null,
                    'webcast': 'https://www.youtube.com/watch?v=0a_00nJ_Y88',
                    'youtube_id': '0a_00nJ_Y88',
                    'article':
                        'https://www.space.com/2196-spacex-inaugural-falcon-1-rocket-lost-launch.html',
                    'wikipedia': 'https://en.wikipedia.org/wiki/DemoSat'
                  },
                  'static_fire_date_utc': '2006-03-17T00:00:00.000Z',
                  'static_fire_date_unix': 1142553600,
                  'net': false,
                  'window': 0,
                  'rocket': '5e9d0d95eda69955f709d1eb',
                  'success': false,
                  'failures': [
                    {
                      'time': 33,
                      'altitude': null,
                      'reason': 'merlin engine failure'
                    }
                  ],
                  'details': 'Engine failure at 33 seconds and loss of vehicle',
                  'crew': [],
                  'ships': [],
                  'capsules': [],
                  'payloads': ['5eb0e4b5b6c3bb0006eeb1e1'],
                  'launchpad': '5e9e4502f5090995de566f86',
                  'flight_number': 1,
                  'name': 'FalconSat',
                  'date_utc': '2006-03-24T22:30:00.000Z',
                  'date_unix': 1143239400,
                  'date_local': '2006-03-25T10:30:00+12:00',
                  'date_precision': 'hour',
                  'upcoming': false,
                  'cores': [
                    {
                      'core': '5e9e289df35918033d3b2623',
                      'flight': 1,
                      'gridfins': false,
                      'legs': false,
                      'reused': false,
                      'landing_attempt': false,
                      'landing_success': null,
                      'landing_type': null,
                      'landpad': null
                    }
                  ],
                  'auto_update': true,
                  'tbd': false,
                  'launch_library_id': null,
                  'id': '5eb87cd9ffd86e000604b32a'
                },
              ],
              'totalDocs': 184,
              'offset': 0,
              'limit': 10,
              'totalPages': 19,
              'page': 1,
              'pagingCounter': 1,
              'hasPrevPage': false,
              'hasNextPage': true,
              'prevPage': null,
              'nextPage': 2
            },
          ),
          isA<Page<Launch>>(),
        );

        expect(
          Page.fromJson<Rocket>(
            {
              'docs': [
                {
                  'height': {'meters': 22.25, 'feet': 73},
                  'diameter': {'meters': 1.68, 'feet': 5.5},
                  'mass': {'kg': 30146, 'lb': 66460},
                  'first_stage': {
                    'thrust_sea_level': {'kN': 420, 'lbf': 94000},
                    'thrust_vacuum': {'kN': 480, 'lbf': 110000},
                    'reusable': false,
                    'engines': 1,
                    'fuel_amount_tons': 44.3,
                    'burn_time_sec': 169
                  },
                  'second_stage': {
                    'thrust': {'kN': 31, 'lbf': 7000},
                    'payloads': {
                      'composite_fairing': {
                        'height': {'meters': 3.5, 'feet': 11.5},
                        'diameter': {'meters': 1.5, 'feet': 4.9}
                      },
                      'option_1': 'composite fairing'
                    },
                    'reusable': false,
                    'engines': 1,
                    'fuel_amount_tons': 3.38,
                    'burn_time_sec': 378
                  },
                  'engines': {
                    'isp': {'sea_level': 267, 'vacuum': 304},
                    'thrust_sea_level': {'kN': 420, 'lbf': 94000},
                    'thrust_vacuum': {'kN': 480, 'lbf': 110000},
                    'number': 1,
                    'type': 'merlin',
                    'version': '1C',
                    'layout': 'single',
                    'engine_loss_max': 0,
                    'propellant_1': 'liquid oxygen',
                    'propellant_2': 'RP-1 kerosene',
                    'thrust_to_weight': 96
                  },
                  'landing_legs': {'number': 0, 'material': null},
                  'payload_weights': [
                    {
                      'id': 'leo',
                      'name': 'Low Earth Orbit',
                      'kg': 450,
                      'lb': 992
                    }
                  ],
                  'flickr_images': [
                    'https://imgur.com/DaCfMsj.jpg',
                    'https://imgur.com/azYafd8.jpg'
                  ],
                  'name': 'Falcon 1',
                  'type': 'rocket',
                  'active': false,
                  'stages': 2,
                  'boosters': 0,
                  'cost_per_launch': 6700000,
                  'success_rate_pct': 40,
                  'first_flight': '2006-03-24',
                  'country': 'Republic of the Marshall Islands',
                  'company': 'SpaceX',
                  'wikipedia': 'https://en.wikipedia.org/wiki/Falcon_1',
                  'description':
                      'The Falcon 1 was an expendable launch system <...>',
                  'id': '5e9d0d95eda69955f709d1eb'
                },
              ],
              'totalDocs': 4,
              'offset': 0,
              'limit': 10,
              'totalPages': 1,
              'page': 1,
              'pagingCounter': 1,
              'hasPrevPage': false,
              'hasNextPage': false,
              'prevPage': null,
              'nextPage': null
            },
          ),
          isA<Page<Rocket>>(),
        );

        expect(
          () => Page.fromJson<Company>(
            {
              'docs': [
                {
                  'headquarters': {
                    'address': 'Rocket Road',
                    'city': 'Hawthorne',
                    'state': 'California'
                  },
                  'links': {
                    'website': 'https://www.spacex.com/',
                    'flickr': 'https://www.flickr.com/photos/spacex/',
                    'twitter': 'https://twitter.com/SpaceX',
                    'elon_twitter': 'https://twitter.com/elonmusk'
                  },
                  'name': 'SpaceX',
                  'founder': 'Elon Musk',
                  'founded': 2002,
                  'employees': 9500,
                  'vehicles': 4,
                  'launch_sites': 3,
                  'test_sites': 3,
                  'ceo': 'Elon Musk',
                  'cto': 'Elon Musk',
                  'coo': 'Gwynne Shotwell',
                  'cto_propulsion': 'Tom Mueller',
                  'valuation': 74000000000,
                  'summary': 'SpaceX designs, manufactures and launches <...>',
                  'id': '5eb75edc42fea42237d7f3ed'
                },
              ],
              'totalDocs': 1,
              'offset': 0,
              'limit': 1,
              'totalPages': 1,
              'page': 1,
              'pagingCounter': 1,
              'hasPrevPage': false,
              'hasNextPage': false,
              'prevPage': null,
              'nextPage': null
            },
          ),
          throwsA(isA<CheckedFromJsonException>()),
        );
      },
    );
  });
}
