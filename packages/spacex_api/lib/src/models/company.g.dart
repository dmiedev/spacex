// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Company _$CompanyFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Company',
      json,
      ($checkedConvert) {
        final val = Company(
          id: $checkedConvert('id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          founder: $checkedConvert('founder', (v) => v as String),
          founded: $checkedConvert('founded', (v) => v as int),
          employees: $checkedConvert('employees', (v) => v as int),
          vehicles: $checkedConvert('vehicles', (v) => v as int),
          launchSites: $checkedConvert('launch_sites', (v) => v as int),
          testSites: $checkedConvert('test_sites', (v) => v as int),
          ceo: $checkedConvert('ceo', (v) => v as String),
          cto: $checkedConvert('cto', (v) => v as String),
          coo: $checkedConvert('coo', (v) => v as String),
          ctoPropulsion: $checkedConvert('cto_propulsion', (v) => v as String),
          valuation: $checkedConvert('valuation', (v) => v as int),
          headquarters: $checkedConvert('headquarters',
              (v) => CompanyEntityLocation.fromJson(v as Map<String, dynamic>)),
          links: $checkedConvert(
              'links', (v) => CompanyLinks.fromJson(v as Map<String, dynamic>)),
          summary: $checkedConvert('summary', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'launchSites': 'launch_sites',
        'testSites': 'test_sites',
        'ctoPropulsion': 'cto_propulsion'
      },
    );

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'founder': instance.founder,
      'founded': instance.founded,
      'employees': instance.employees,
      'vehicles': instance.vehicles,
      'launch_sites': instance.launchSites,
      'test_sites': instance.testSites,
      'ceo': instance.ceo,
      'cto': instance.cto,
      'coo': instance.coo,
      'cto_propulsion': instance.ctoPropulsion,
      'valuation': instance.valuation,
      'headquarters': instance.headquarters.toJson(),
      'links': instance.links.toJson(),
      'summary': instance.summary,
    };

CompanyEntityLocation _$CompanyEntityLocationFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'CompanyEntityLocation',
      json,
      ($checkedConvert) {
        final val = CompanyEntityLocation(
          address: $checkedConvert('address', (v) => v as String),
          city: $checkedConvert('city', (v) => v as String),
          state: $checkedConvert('state', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$CompanyEntityLocationToJson(
        CompanyEntityLocation instance) =>
    <String, dynamic>{
      'address': instance.address,
      'city': instance.city,
      'state': instance.state,
    };

CompanyLinks _$CompanyLinksFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CompanyLinks',
      json,
      ($checkedConvert) {
        final val = CompanyLinks(
          website: $checkedConvert('website', (v) => v as String),
          flickr: $checkedConvert('flickr', (v) => v as String),
          twitter: $checkedConvert('twitter', (v) => v as String),
          elonTwitter: $checkedConvert('elon_twitter', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'elonTwitter': 'elon_twitter'},
    );

Map<String, dynamic> _$CompanyLinksToJson(CompanyLinks instance) =>
    <String, dynamic>{
      'website': instance.website,
      'flickr': instance.flickr,
      'twitter': instance.twitter,
      'elon_twitter': instance.elonTwitter,
    };
