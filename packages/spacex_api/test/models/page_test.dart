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
                    'recovery_attempt': true,
                    'recovered': false,
                    'ships': ['5ea6ed2e080df4000697c908']
                  },
                  'links': {
                    'patch': {
                      'small':
                          'https://images2.imgbox.com/02/51/7NLaBm8c_o.png',
                      'large': 'https://images2.imgbox.com/69/f5/04lBXd2F_o.png'
                    },
                    'reddit': {
                      'campaign':
                          'https://www.reddit.com/r/spacex/comments/73ttkd/koreasat_5a_launch_campaign_thread/',
                      'launch':
                          'https://www.reddit.com/r/spacex/comments/79iuvb/rspacex_koreasat_5a_official_launch_discussion/',
                      'media':
                          'https://www.reddit.com/r/spacex/comments/79lmdu/rspacex_koreasat5a_media_thread_videos_images/',
                      'recovery': null
                    },
                    'flickr': {
                      'small': [],
                      'original': [
                        'https://farm5.staticflickr.com/4477/38056454431_a5f40f9fd7_o.jpg',
                        'https://farm5.staticflickr.com/4455/26280153979_b8016a829f_o.jpg',
                        'https://farm5.staticflickr.com/4459/38056455051_79ef2b949a_o.jpg',
                        'https://farm5.staticflickr.com/4466/26280153539_ecbc2b3fa9_o.jpg',
                        'https://farm5.staticflickr.com/4482/26280154209_bf08d76361_o.jpg',
                        'https://farm5.staticflickr.com/4493/38056455211_a4565a9cee_o.jpg'
                      ]
                    },
                    'presskit':
                        'http://www.spacex.com/sites/spacex/files/koreasat5apresskit.pdf',
                    'webcast': 'https://www.youtube.com/watch?v=RUjH14vhLxA',
                    'youtube_id': 'RUjH14vhLxA',
                    'article':
                        'https://spaceflightnow.com/2017/10/30/spacex-launches-and-lands-third-rocket-in-three-weeks/',
                    'wikipedia': 'https://en.wikipedia.org/wiki/Koreasat_5A'
                  },
                  'static_fire_date_utc': '2017-10-26T16:00:00.000Z',
                  'static_fire_date_unix': 1509033600,
                  'tdb': false,
                  'net': false,
                  'window': 8640,
                  'rocket': '5e9d0d95eda69973a809d1ec',
                  'success': true,
                  'failures': [],
                  'details':
                      'KoreaSat 5A is a Ku-band satellite capable of <...>',
                  'crew': [],
                  'ships': [
                    '5ea6ed2f080df4000697c90d',
                    '5ea6ed2e080df4000697c908',
                    '5ea6ed30080df4000697c913'
                  ],
                  'capsules': [],
                  'payloads': ['5eb0e4c5b6c3bb0006eeb217'],
                  'launchpad': '5e9e4502f509094188566f88',
                  'auto_update': true,
                  'flight_number': 50,
                  'name': 'KoreaSat 5A',
                  'date_utc': '2017-10-30T19:34:00.000Z',
                  'date_unix': 1509392040,
                  'date_local': '2017-10-30T15:34:00-04:00',
                  'date_precision': 'hour',
                  'upcoming': false,
                  'cores': [
                    {
                      'core': '5e9e28a4f359185cc03b2651',
                      'flight': 1,
                      'gridfins': true,
                      'legs': true,
                      'reused': false,
                      'landing_attempt': true,
                      'landing_success': true,
                      'landing_type': 'ASDS',
                      'landpad': '5e9e3032383ecb6bb234e7ca'
                    }
                  ],
                  'id': '5eb87d0dffd86e000604b35b'
                }
              ],
              'totalDocs': 109,
              'limit': 10,
              'totalPages': 11,
              'page': 5,
              'pagingCounter': 41,
              'hasPrevPage': true,
              'hasNextPage': true,
              'prevPage': 4,
              'nextPage': 6
            },
          ),
          isA<Page<Launch>>(),
        );

        expect(
          Page.fromJson<Rocket>(
            {
              'docs': [
                {
                  'height': {'meters': 70, 'feet': 229.6},
                  'diameter': {'meters': 3.7, 'feet': 12},
                  'mass': {'kg': 549054, 'lb': 1207920},
                  'first_stage': {
                    'thrust_sea_level': {'kN': 7607, 'lbf': 1710000},
                    'thrust_vacuum': {'kN': 8227, 'lbf': 1849500},
                    'reusable': true,
                    'engines': 9,
                    'fuel_amount_tons': 385,
                    'burn_time_sec': 162
                  },
                  'second_stage': {
                    'thrust': {'kN': 934, 'lbf': 210000},
                    'payloads': {
                      'composite_fairing': {
                        'height': {'meters': 13.1, 'feet': 43},
                        'diameter': {'meters': 5.2, 'feet': 17.1}
                      },
                      'option_1': 'dragon'
                    },
                    'reusable': false,
                    'engines': 1,
                    'fuel_amount_tons': 90,
                    'burn_time_sec': 397
                  },
                  'engines': {
                    'isp': {'sea_level': 288, 'vacuum': 312},
                    'thrust_sea_level': {'kN': 845, 'lbf': 190000},
                    'thrust_vacuum': {'kN': 914, 'lbf': 205500},
                    'number': 9,
                    'type': 'merlin',
                    'version': '1D+',
                    'layout': 'octaweb',
                    'engine_loss_max': 2,
                    'propellant_1': 'liquid oxygen',
                    'propellant_2': 'RP-1 kerosene',
                    'thrust_to_weight': 180.1
                  },
                  'landing_legs': {'number': 4, 'material': 'carbon fiber'},
                  'payload_weights': [
                    {
                      'id': 'leo',
                      'name': 'Low Earth Orbit',
                      'kg': 22800,
                      'lb': 50265
                    },
                    {
                      'id': 'gto',
                      'name': 'Geosynchronous Transfer Orbit',
                      'kg': 8300,
                      'lb': 18300
                    },
                    {'id': 'mars', 'name': 'Mars Orbit', 'kg': 4020, 'lb': 8860}
                  ],
                  'flickr_images': [
                    'https://farm1.staticflickr.com/929/28787338307_3453a11a77_b.jpg',
                    'https://farm4.staticflickr.com/3955/32915197674_eee74d81bb_b.jpg',
                    'https://farm1.staticflickr.com/293/32312415025_6841e30bf1_b.jpg',
                    'https://farm1.staticflickr.com/623/23660653516_5b6cb301d1_b.jpg',
                    'https://farm6.staticflickr.com/5518/31579784413_d853331601_b.jpg',
                    'https://farm1.staticflickr.com/745/32394687645_a9c54a34ef_b.jpg'
                  ],
                  'name': 'Falcon 9',
                  'type': 'rocket',
                  'active': true,
                  'stages': 2,
                  'boosters': 0,
                  'cost_per_launch': 50000000,
                  'success_rate_pct': 97,
                  'first_flight': '2010-06-04',
                  'country': 'United States',
                  'company': 'SpaceX',
                  'wikipedia': 'https://en.wikipedia.org/wiki/Falcon_9',
                  'description':
                      'Falcon 9 is a two-stage rocket designed and <...>',
                  'id': '5e9d0d95eda69973a809d1ec'
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
