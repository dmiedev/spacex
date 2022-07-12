// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Launch _$LaunchFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Launch',
      json,
      ($checkedConvert) {
        final val = Launch(
          id: $checkedConvert('id', (v) => v as String),
          launchLibraryId:
              $checkedConvert('launch_library_id', (v) => v as String?),
          flightNumber: $checkedConvert('flight_number', (v) => v as int),
          name: $checkedConvert('name', (v) => v as String),
          dateUtc:
              $checkedConvert('date_utc', (v) => DateTime.parse(v as String)),
          dateLocal:
              $checkedConvert('date_local', (v) => DateTime.parse(v as String)),
          datePrecision: $checkedConvert('date_precision',
              (v) => $enumDecode(_$DateTimePrecisionEnumMap, v)),
          staticFireDate: $checkedConvert('static_fire_date_utc',
              (v) => v == null ? null : DateTime.parse(v as String)),
          tbd: $checkedConvert('tbd', (v) => v as bool? ?? false),
          net: $checkedConvert('net', (v) => v as bool? ?? false),
          window: $checkedConvert('window', (v) => v as int?),
          rocket: $checkedConvert('rocket', (v) => v as String?),
          success: $checkedConvert('success', (v) => v as bool?),
          failures: $checkedConvert(
              'failures',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) =>
                          LaunchFailure.fromJson(e as Map<String, dynamic>))
                      .toList() ??
                  const []),
          upcoming: $checkedConvert('upcoming', (v) => v as bool),
          details: $checkedConvert('details', (v) => v as String?),
          fairings: $checkedConvert(
              'fairings',
              (v) => v == null
                  ? null
                  : LaunchFairingsRecovery.fromJson(v as Map<String, dynamic>)),
          crew: $checkedConvert(
              'crew',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) =>
                          LaunchCrewMember.fromJson(e as Map<String, dynamic>))
                      .toList() ??
                  const []),
          ships: $checkedConvert(
              'ships',
              (v) =>
                  (v as List<dynamic>?)?.map((e) => e as String).toList() ??
                  const []),
          capsules: $checkedConvert(
              'capsules',
              (v) =>
                  (v as List<dynamic>?)?.map((e) => e as String).toList() ??
                  const []),
          payloads: $checkedConvert(
              'payloads',
              (v) =>
                  (v as List<dynamic>?)?.map((e) => e as String).toList() ??
                  const []),
          launchpad: $checkedConvert('launchpad', (v) => v as String?),
          cores: $checkedConvert(
              'cores',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map(
                          (e) => LaunchCore.fromJson(e as Map<String, dynamic>))
                      .toList() ??
                  const []),
          links: $checkedConvert(
              'links', (v) => LaunchLinks.fromJson(v as Map<String, dynamic>)),
          autoUpdate: $checkedConvert('auto_update', (v) => v as bool? ?? true),
        );
        return val;
      },
      fieldKeyMap: const {
        'launchLibraryId': 'launch_library_id',
        'flightNumber': 'flight_number',
        'dateUtc': 'date_utc',
        'dateLocal': 'date_local',
        'datePrecision': 'date_precision',
        'staticFireDate': 'static_fire_date_utc',
        'autoUpdate': 'auto_update'
      },
    );

Map<String, dynamic> _$LaunchToJson(Launch instance) => <String, dynamic>{
      'id': instance.id,
      'launch_library_id': instance.launchLibraryId,
      'flight_number': instance.flightNumber,
      'name': instance.name,
      'date_utc': instance.dateUtc.toIso8601String(),
      'date_local': instance.dateLocal.toIso8601String(),
      'date_precision': _$DateTimePrecisionEnumMap[instance.datePrecision],
      'static_fire_date_utc': instance.staticFireDate?.toIso8601String(),
      'tbd': instance.tbd,
      'net': instance.net,
      'window': instance.window,
      'rocket': instance.rocket,
      'success': instance.success,
      'failures': instance.failures.map((e) => e.toJson()).toList(),
      'upcoming': instance.upcoming,
      'details': instance.details,
      'fairings': instance.fairings?.toJson(),
      'crew': instance.crew.map((e) => e.toJson()).toList(),
      'ships': instance.ships,
      'capsules': instance.capsules,
      'payloads': instance.payloads,
      'launchpad': instance.launchpad,
      'cores': instance.cores.map((e) => e.toJson()).toList(),
      'links': instance.links.toJson(),
      'auto_update': instance.autoUpdate,
    };

const _$DateTimePrecisionEnumMap = {
  DateTimePrecision.half: 'half',
  DateTimePrecision.quarter: 'quarter',
  DateTimePrecision.year: 'year',
  DateTimePrecision.month: 'month',
  DateTimePrecision.day: 'day',
  DateTimePrecision.hour: 'hour',
};

LaunchFairingsRecovery _$LaunchFairingsRecoveryFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'LaunchFairingsRecovery',
      json,
      ($checkedConvert) {
        final val = LaunchFairingsRecovery(
          reused: $checkedConvert('reused', (v) => v as bool?),
          recoveryAttempt:
              $checkedConvert('recovery_attempt', (v) => v as bool?),
          recovered: $checkedConvert('recovered', (v) => v as bool?),
          ships: $checkedConvert(
              'ships',
              (v) =>
                  (v as List<dynamic>?)?.map((e) => e as String).toList() ??
                  const []),
        );
        return val;
      },
      fieldKeyMap: const {'recoveryAttempt': 'recovery_attempt'},
    );

Map<String, dynamic> _$LaunchFairingsRecoveryToJson(
        LaunchFairingsRecovery instance) =>
    <String, dynamic>{
      'reused': instance.reused,
      'recovery_attempt': instance.recoveryAttempt,
      'recovered': instance.recovered,
      'ships': instance.ships,
    };

LaunchFailure _$LaunchFailureFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'LaunchFailure',
      json,
      ($checkedConvert) {
        final val = LaunchFailure(
          time: $checkedConvert('time', (v) => v as int?),
          altitude: $checkedConvert('altitude', (v) => v as int?),
          reason: $checkedConvert('reason', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$LaunchFailureToJson(LaunchFailure instance) =>
    <String, dynamic>{
      'time': instance.time,
      'altitude': instance.altitude,
      'reason': instance.reason,
    };

LaunchCrewMember _$LaunchCrewMemberFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'LaunchCrewMember',
      json,
      ($checkedConvert) {
        final val = LaunchCrewMember(
          id: $checkedConvert('crew', (v) => v as String?),
          role: $checkedConvert('role', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {'id': 'crew'},
    );

Map<String, dynamic> _$LaunchCrewMemberToJson(LaunchCrewMember instance) =>
    <String, dynamic>{
      'crew': instance.id,
      'role': instance.role,
    };

LaunchCore _$LaunchCoreFromJson(Map<String, dynamic> json) => $checkedCreate(
      'LaunchCore',
      json,
      ($checkedConvert) {
        final val = LaunchCore(
          id: $checkedConvert('core', (v) => v as String?),
          flight: $checkedConvert('flight', (v) => v as int?),
          gridFins: $checkedConvert('gridfins', (v) => v as bool?),
          legs: $checkedConvert('legs', (v) => v as bool?),
          reused: $checkedConvert('reused', (v) => v as bool?),
          landingAttempt: $checkedConvert('landing_attempt', (v) => v as bool?),
          landingSuccess: $checkedConvert('landing_success', (v) => v as bool?),
          landingType: $checkedConvert('landing_type', (v) => v as String?),
          landpad: $checkedConvert('landpad', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'id': 'core',
        'gridFins': 'gridfins',
        'landingAttempt': 'landing_attempt',
        'landingSuccess': 'landing_success',
        'landingType': 'landing_type'
      },
    );

Map<String, dynamic> _$LaunchCoreToJson(LaunchCore instance) =>
    <String, dynamic>{
      'core': instance.id,
      'flight': instance.flight,
      'gridfins': instance.gridFins,
      'legs': instance.legs,
      'reused': instance.reused,
      'landing_attempt': instance.landingAttempt,
      'landing_success': instance.landingSuccess,
      'landing_type': instance.landingType,
      'landpad': instance.landpad,
    };
