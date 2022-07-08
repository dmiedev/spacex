// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Company _$CompanyFromJson(Map<String, dynamic> json) => Company(
      id: json['id'] as int,
      name: json['name'] as String,
      founder: json['founder'] as String,
      founded: json['founded'] as int,
      employees: json['employees'] as int,
      vehicles: json['vehicles'] as int,
      launchSites: json['launch_sites'] as int,
      testSites: json['test_sites'] as int,
      ceo: json['ceo'] as String,
      cto: json['cto'] as String,
      coo: json['coo'] as String,
      ctoPropulsion: json['cto_propulsion'] as String,
      valuation: json['valuation'] as int,
      headquarters: CompanyEntityLocation.fromJson(
          json['headquarters'] as Map<String, dynamic>),
      links: CompanyLinks.fromJson(json['links'] as Map<String, dynamic>),
      summary: json['summary'] as String,
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
      'headquarters': instance.headquarters,
      'links': instance.links,
      'summary': instance.summary,
    };

CompanyEntityLocation _$CompanyEntityLocationFromJson(
        Map<String, dynamic> json) =>
    CompanyEntityLocation(
      address: json['address'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
    );

Map<String, dynamic> _$CompanyEntityLocationToJson(
        CompanyEntityLocation instance) =>
    <String, dynamic>{
      'address': instance.address,
      'city': instance.city,
      'state': instance.state,
    };

CompanyLinks _$CompanyLinksFromJson(Map<String, dynamic> json) => CompanyLinks(
      website: json['website'] as String,
      flickr: json['flickr'] as String,
      twitter: json['twitter'] as String,
      elonTwitter: json['elon_twitter'] as String,
    );

Map<String, dynamic> _$CompanyLinksToJson(CompanyLinks instance) =>
    <String, dynamic>{
      'website': instance.website,
      'flickr': instance.flickr,
      'twitter': instance.twitter,
      'elon_twitter': instance.elonTwitter,
    };
