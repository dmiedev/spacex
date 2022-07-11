// ignore_for_file: prefer_const_constructors

import 'package:spacex_api/spacex_api.dart';
import 'package:test/test.dart';

void main() {
  final company = Company(
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

  group('Company', () {
    test('supports value comparisons', () {
      expect(
        company,
        equals(
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
        ),
      );
    });

    test('.fromJson() returns correct result', () {
      expect(
        Company.fromJson({
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
          'employees': 8000,
          'vehicles': 3,
          'launch_sites': 3,
          'test_sites': 1,
          'ceo': 'Elon Musk',
          'cto': 'Elon Musk',
          'coo': 'Gwynne Shotwell',
          'cto_propulsion': 'Tom Mueller',
          'valuation': 52000000000,
          'summary':
              'SpaceX designs, manufactures and launches advanced rockets and'
                  ' spacecraft.',
          'id': '5eb75edc42fea42237d7f3ed'
        }),
        isA<Company>()
            .having((company) => company.links, 'links', isA<CompanyLinks>())
            .having(
              (company) => company.headquarters,
              'headquarters',
              isA<CompanyEntityLocation>(),
            ),
      );
    });

    test('.toJson() returns correct result', () {
      expect(
        company.toJson(),
        isA<Map<String, dynamic>>()
            .having(
              (json) => json['cto_propulsion'],
              'ctoPropulsion',
              isNotNull,
            )
            .having(
              (json) => json['links'],
              'links',
              isA<Map<String, dynamic>>(),
            )
            .having(
              (json) => json['headquarters'],
              'headquarters',
              isA<Map<String, dynamic>>(),
            ),
      );
    });
  });
}
