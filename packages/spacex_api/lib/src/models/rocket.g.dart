// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rocket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rocket _$RocketFromJson(Map<String, dynamic> json) => Rocket(
      id: json['id'] as String,
      name: json['name'] as String,
      active: json['active'] as bool,
      stages: json['stages'] as int,
      boosters: json['boosters'] as int,
      costPerLaunch: json['cost_per_launch'] as int,
      successRatePct: json['success_rate_pct'] as int,
      firstFlight: DateTime.parse(json['first_flight'] as String),
      country: json['country'] as String,
      company: json['company'] as String,
      height: Length.fromJson(json['height'] as Map<String, dynamic>),
      diameter: Length.fromJson(json['diameter'] as Map<String, dynamic>),
      mass: Mass.fromJson(json['mass'] as Map<String, dynamic>),
      flickrImages: (json['flickr_images'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      wikipedia: json['wikipedia'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$RocketToJson(Rocket instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'active': instance.active,
      'stages': instance.stages,
      'boosters': instance.boosters,
      'cost_per_launch': instance.costPerLaunch,
      'success_rate_pct': instance.successRatePct,
      'first_flight': instance.firstFlight.toIso8601String(),
      'country': instance.country,
      'company': instance.company,
      'height': instance.height.toJson(),
      'diameter': instance.diameter.toJson(),
      'mass': instance.mass.toJson(),
      'flickr_images': instance.flickrImages,
      'wikipedia': instance.wikipedia,
      'description': instance.description,
    };

Length _$LengthFromJson(Map<String, dynamic> json) => Length(
      meters: (json['meters'] as num).toDouble(),
      feet: (json['feet'] as num).toDouble(),
    );

Map<String, dynamic> _$LengthToJson(Length instance) => <String, dynamic>{
      'meters': instance.meters,
      'feet': instance.feet,
    };

Mass _$MassFromJson(Map<String, dynamic> json) => Mass(
      kg: json['kg'] as int,
      lb: json['lb'] as int,
    );

Map<String, dynamic> _$MassToJson(Mass instance) => <String, dynamic>{
      'kg': instance.kg,
      'lb': instance.lb,
    };