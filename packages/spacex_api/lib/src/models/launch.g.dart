// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Launch _$LaunchFromJson(Map<String, dynamic> json) => Launch(
      id: json['id'] as String,
      launchLibraryId: json['launch_library_id'] as String?,
      flightNumber: json['flight_number'] as int,
      name: json['name'] as String,
      dateUtc: DateTime.parse(json['date_utc'] as String),
      dateLocal: DateTime.parse(json['date_local'] as String),
      datePrecision:
          $enumDecode(_$DateTimePrecisionEnumMap, json['date_precision']),
      staticFireDate: json['static_fire_date_utc'] == null
          ? null
          : DateTime.parse(json['static_fire_date_utc'] as String),
      tbd: json['tbd'] as bool? ?? false,
      net: json['net'] as bool? ?? false,
      window: json['window'] as int?,
      rocket: json['rocket'] as String?,
      success: json['success'] as bool?,
      failures: (json['failures'] as List<dynamic>?)
              ?.map((e) => LaunchFailure.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      upcoming: json['upcoming'] as bool,
      details: json['details'] as String?,
      fairings: json['fairings'] == null
          ? null
          : LaunchFairingsRecovery.fromJson(
              json['fairings'] as Map<String, dynamic>),
      crew: (json['crew'] as List<dynamic>?)
              ?.map((e) => LaunchCrewMember.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      ships:
          (json['ships'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      capsules: (json['capsules'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      payloads: (json['payloads'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      launchpad: json['launchpad'] as String?,
      cores: (json['cores'] as List<dynamic>?)
              ?.map((e) => LaunchCore.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      links: LaunchLinks.fromJson(json['links'] as Map<String, dynamic>),
      autoUpdate: json['auto_update'] as bool? ?? true,
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
      'failures': instance.failures,
      'upcoming': instance.upcoming,
      'details': instance.details,
      'fairings': instance.fairings,
      'crew': instance.crew,
      'ships': instance.ships,
      'capsules': instance.capsules,
      'payloads': instance.payloads,
      'launchpad': instance.launchpad,
      'cores': instance.cores,
      'links': instance.links,
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
    LaunchFairingsRecovery(
      reused: json['reused'] as bool?,
      recoveryAttempt: json['recovery_attempt'] as bool?,
      recovered: json['recovered'] as bool?,
      ships:
          (json['ships'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
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
    LaunchFailure(
      time: json['time'] as int?,
      altitude: json['altitude'] as int?,
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$LaunchFailureToJson(LaunchFailure instance) =>
    <String, dynamic>{
      'time': instance.time,
      'altitude': instance.altitude,
      'reason': instance.reason,
    };

LaunchCrewMember _$LaunchCrewMemberFromJson(Map<String, dynamic> json) =>
    LaunchCrewMember(
      id: json['crew'] as String?,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$LaunchCrewMemberToJson(LaunchCrewMember instance) =>
    <String, dynamic>{
      'crew': instance.id,
      'role': instance.role,
    };

LaunchCore _$LaunchCoreFromJson(Map<String, dynamic> json) => LaunchCore(
      id: json['core'] as String?,
      flight: json['flight'] as int?,
      gridFins: json['gridfins'] as bool?,
      legs: json['legs'] as bool?,
      reused: json['reused'] as bool?,
      landingAttempt: json['landing_attempt'] as bool?,
      landingSuccess: json['landing_success'] as bool?,
      landingType: json['landing_type'] as String?,
      landpad: json['landpad'] as String?,
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
