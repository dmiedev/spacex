// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rocket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rocket _$RocketFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Rocket',
      json,
      ($checkedConvert) {
        final val = Rocket(
          id: $checkedConvert('id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String?),
          active: $checkedConvert('active', (v) => v as bool?),
          stages: $checkedConvert('stages', (v) => v as int?),
          boosters: $checkedConvert('boosters', (v) => v as int?),
          costPerLaunch: $checkedConvert('cost_per_launch', (v) => v as int?),
          successRatePct: $checkedConvert('success_rate_pct', (v) => v as int?),
          firstFlight: $checkedConvert('first_flight',
              (v) => v == null ? null : DateTime.parse(v as String)),
          country: $checkedConvert('country', (v) => v as String?),
          company: $checkedConvert('company', (v) => v as String?),
          height: $checkedConvert(
              'height',
              (v) => v == null
                  ? null
                  : Length.fromJson(v as Map<String, dynamic>)),
          diameter: $checkedConvert(
              'diameter',
              (v) => v == null
                  ? null
                  : Length.fromJson(v as Map<String, dynamic>)),
          mass: $checkedConvert(
              'mass',
              (v) =>
                  v == null ? null : Mass.fromJson(v as Map<String, dynamic>)),
          flickrImages: $checkedConvert('flickr_images',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
          wikipedia: $checkedConvert('wikipedia', (v) => v as String?),
          description: $checkedConvert('description', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'costPerLaunch': 'cost_per_launch',
        'successRatePct': 'success_rate_pct',
        'firstFlight': 'first_flight',
        'flickrImages': 'flickr_images'
      },
    );

Map<String, dynamic> _$RocketToJson(Rocket instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'active': instance.active,
      'stages': instance.stages,
      'boosters': instance.boosters,
      'cost_per_launch': instance.costPerLaunch,
      'success_rate_pct': instance.successRatePct,
      'first_flight': instance.firstFlight?.toIso8601String(),
      'country': instance.country,
      'company': instance.company,
      'height': instance.height?.toJson(),
      'diameter': instance.diameter?.toJson(),
      'mass': instance.mass?.toJson(),
      'flickr_images': instance.flickrImages,
      'wikipedia': instance.wikipedia,
      'description': instance.description,
    };

Length _$LengthFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Length',
      json,
      ($checkedConvert) {
        final val = Length(
          meters: $checkedConvert('meters', (v) => (v as num?)?.toDouble()),
          feet: $checkedConvert('feet', (v) => (v as num?)?.toDouble()),
        );
        return val;
      },
    );

Map<String, dynamic> _$LengthToJson(Length instance) => <String, dynamic>{
      'meters': instance.meters,
      'feet': instance.feet,
    };

Mass _$MassFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Mass',
      json,
      ($checkedConvert) {
        final val = Mass(
          kg: $checkedConvert('kg', (v) => v as int?),
          lb: $checkedConvert('lb', (v) => v as int?),
        );
        return val;
      },
    );

Map<String, dynamic> _$MassToJson(Mass instance) => <String, dynamic>{
      'kg': instance.kg,
      'lb': instance.lb,
    };
