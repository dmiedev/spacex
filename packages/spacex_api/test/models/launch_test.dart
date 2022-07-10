// ignore_for_file: prefer_const_constructors
// ignore_for_file: inference_failure_on_collection_literal
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:spacex_api/spacex_api.dart';
import 'package:test/test.dart';

void main() {
  final launch = Launch(
    id: '123',
    flightNumber: 111,
    name: 'CR-123',
    dateUtc: DateTime(2017, 9, 7),
    dateLocal: DateTime(2017, 9, 6),
    datePrecision: DateTimePrecision.day,
    upcoming: false,
    staticFireDate: DateTime(2017, 3, 4),
    window: 1,
    rocket: '1222',
    success: false,
    details: 'launch',
    crew: [LaunchCrewMember(id: '1', role: 'Captain')],
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
      LaunchCore(reused: true, landingType: 'ABC'),
    ],
  );

  group('Launch', () {
    test('supports value comparisons', () {
      expect(
        launch,
        equals(
          Launch(
            id: '123',
            flightNumber: 111,
            name: 'CR-123',
            dateUtc: DateTime(2017, 9, 7),
            dateLocal: DateTime(2017, 9, 6),
            datePrecision: DateTimePrecision.day,
            upcoming: false,
            staticFireDate: DateTime(2017, 3, 4),
            window: 1,
            rocket: '1222',
            success: false,
            details: 'launch',
            crew: [LaunchCrewMember(id: '1', role: 'Captain')],
            ships: ['1010101010'],
            payloads: ['asdf2', 'asdf1'],
            capsules: ['123', '321'],
            launchpad: '654321',
            launchLibraryId: '123321',
            links: LaunchLinks(
              flickr:
                  FlickrLaunchLinks(original: ['link 1'], small: ['link 2']),
            ),
            failures: [
              LaunchFailure(time: 123, reason: 'failure reason'),
            ],
            fairings: LaunchFairingsRecovery(recoveryAttempt: true),
            cores: [
              LaunchCore(reused: true, landingType: 'ABC'),
            ],
          ),
        ),
      );
    });

    test('.fromJson() returns normally', () {
      expect(
        Launch.fromJson(
          {
            'fairings': {'recovery': true},
            'links': {
              'patch': {
                'small': 'https://images2.imgbox.com/53/22/dh0XSLXO_o.png',
                'large': 'https://images2.imgbox.com/15/2b/NAcsTEB6_o.png'
              },
              'reddit': {
                'campaign':
                    'https://www.reddit.com/r/spacex/comments/ezn6n0/crs20_launch_campaign_thread',
                'launch':
                    'https://www.reddit.com/r/spacex/comments/fe8pcj/rspacex_crs20_official_launch_discussion_updates/',
                'media':
                    'https://www.reddit.com/r/spacex/comments/fes64p/rspacex_crs20_media_thread_videos_images_gifs/',
                'recovery': null
              },
              'flickr': {
                'small': [],
                'original': [
                  'https://live.staticflickr.com/65535/49635401403_96f9c322dc_o.jpg',
                  'https://live.staticflickr.com/65535/49636202657_e81210a3ca_o.jpg',
                  'https://live.staticflickr.com/65535/49636202572_8831c5a917_o.jpg',
                  'https://live.staticflickr.com/65535/49635401423_e0bef3e82f_o.jpg',
                  'https://live.staticflickr.com/65535/49635985086_660be7062f_o.jpg'
                ]
              },
              'presskit':
                  'https://www.spacex.com/sites/spacex/files/crs-20_mission_press_kit.pdf',
              'webcast': 'https://youtu.be/1MkcWK2PnsU',
              'youtube_id': '1MkcWK2PnsU',
              'article':
                  'https://spaceflightnow.com/2020/03/07/late-night-launch-of-spacex-cargo-ship-marks-end-of-an-era/',
              'wikipedia': 'https://en.wikipedia.org/wiki/SpaceX_CRS-20'
            },
            'static_fire_date_utc': '2020-03-01T10:20:00.000Z',
            'static_fire_date_unix': 1583058000,
            'tdb': false,
            'net': false,
            'window': 0,
            'rocket': '5e9d0d95eda69973a809d1ec',
            'success': true,
            'failures': [
              {'time': 33, 'altitude': null, 'reason': 'engine failure'},
            ],
            'details': "SpaceX's 20th and final Crew Resupply Mission under "
                'the original NASA CRS contract, this mission brings essential '
                "supplies to the International Space Station using SpaceX's "
                'reusable Dragon spacecraft.',
            'crew': [
              {'id': '6243bc5baf52800c6e919276', 'role': 'Commander'}
            ],
            'ships': ['43bc5baf5243bc5baf52'],
            'capsules': ['5e9e2c5cf359185d753b266f'],
            'payloads': ['5eb0e4d0b6c3bb0006eeb253'],
            'launchpad': '5e9e4501f509094ba4566f84',
            'auto_update': true,
            'flight_number': 91,
            'name': 'CRS-20',
            'date_utc': '2020-03-07T04:50:31.000Z',
            'date_unix': 1583556631,
            'date_local': '2020-03-06T23:50:31-05:00',
            'date_precision': 'hour',
            'upcoming': false,
            'cores': [
              {
                'core': '5e9e28a7f359187afd3b2662',
                'flight': 2,
                'gridfins': true,
                'legs': true,
                'reused': true,
                'landing_attempt': true,
                'landing_success': true,
                'landing_type': 'RTLS',
                'landpad': '5e9e3032383ecb267a34e7c7'
              }
            ],
            'id': '5eb87d42ffd86e000604b384'
          },
        ),
        isA<Launch>()
            .having(
              (launch) => launch.datePrecision,
              'datePrecision',
              isA<DateTimePrecision>(),
            )
            .having(
              (launch) => launch.staticFireDate,
              'staticFireDate',
              isA<DateTime>(),
            )
            .having(
              (launch) => launch.failures,
              'failures',
              isA<List<LaunchFailure>>(),
            )
            .having(
              (launch) => launch.fairings,
              'fairings',
              isA<LaunchFairingsRecovery>(),
            )
            .having(
              (launch) => launch.links,
              'links',
              isA<LaunchLinks>(),
            )
            .having(
              (launch) => launch.links.patch,
              'links.patch',
              isA<PatchLinks>(),
            )
            .having(
              (launch) => launch.links.reddit,
              'links.reddit',
              isA<RedditLaunchLinks>(),
            )
            .having(
              (launch) => launch.links.flickr,
              'links.flickr',
              isA<FlickrLaunchLinks>(),
            )
            .having(
              (launch) => launch.crew,
              'crew',
              isA<List<LaunchCrewMember>>(),
            )
            .having(
              (launch) => launch.cores,
              'cores',
              isA<List<LaunchCore>>(),
            ),
      );
    });

    test('.toJson returns normally', () {
      expect(
        launch.toJson(),
        isA<Map<String, dynamic>>()
            .having(
              (json) => json['static_fire_date_utc'],
              'staticFireDate',
              isA<String>(),
            )
            .having(
              (json) => json['date_precision'],
              'datePrecision',
              isA<String>(),
            )
            .having(
              (json) => json['failures'],
              'failures',
              isA<List<Map<String, dynamic>>>(),
            )
            .having(
              (json) => json['fairings'],
              'failures',
              isA<Map<String, dynamic>>(),
            )
            .having(
              (json) => json['crew'],
              'crew',
              isA<List<Map<String, dynamic>>>(),
            )
            .having(
              (json) => json['cores'],
              'cores',
              isA<List<Map<String, dynamic>>>(),
            )
            .having(
              (json) => json['links'],
              'links',
              isA<Map<String, dynamic>>(),
            )
            .having(
              (json) => (json['links'] as Map<String, dynamic>)['patch'],
              'links.patch',
              isA<Map<String, dynamic>>(),
            )
            .having(
              (json) => (json['links'] as Map<String, dynamic>)['flickr'],
              'links.flickr',
              isA<Map<String, dynamic>>(),
            )
            .having(
              (json) => (json['links'] as Map<String, dynamic>)['reddit'],
              'links.reddit',
              isA<Map<String, dynamic>>(),
            ),
      );
    });
  });
}
