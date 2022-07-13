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
          flightNumber: $checkedConvert('flight_number', (v) => v as int?),
          name: $checkedConvert('name', (v) => v as String?),
          dateUtc: $checkedConvert('date_utc',
              (v) => v == null ? null : DateTime.parse(v as String)),
          dateLocal: $checkedConvert('date_local',
              (v) => v == null ? null : DateTime.parse(v as String)),
          datePrecision: $checkedConvert('date_precision',
              (v) => $enumDecodeNullable(_$DateTimePrecisionEnumMap, v)),
          staticFireDateUtc: $checkedConvert('static_fire_date_utc',
              (v) => v == null ? null : DateTime.parse(v as String)),
          tbd: $checkedConvert('tbd', (v) => v as bool?),
          net: $checkedConvert('net', (v) => v as bool?),
          window: $checkedConvert('window', (v) => v as int?),
          rocket: $checkedConvert('rocket', (v) => v as String?),
          success: $checkedConvert('success', (v) => v as bool?),
          failures: $checkedConvert(
              'failures',
              (v) => (v as List<dynamic>?)
                  ?.map(
                      (e) => LaunchFailure.fromJson(e as Map<String, dynamic>))
                  .toList()),
          upcoming: $checkedConvert('upcoming', (v) => v as bool?),
          details: $checkedConvert('details', (v) => v as String?),
          fairings: $checkedConvert(
              'fairings',
              (v) => v == null
                  ? null
                  : LaunchFairingsRecovery.fromJson(v as Map<String, dynamic>)),
          crew: $checkedConvert(
              'crew',
              (v) => (v as List<dynamic>?)
                  ?.map((e) =>
                      LaunchCrewMember.fromJson(e as Map<String, dynamic>))
                  .toList()),
          ships: $checkedConvert('ships',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
          capsules: $checkedConvert('capsules',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
          payloads: $checkedConvert('payloads',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
          launchpad: $checkedConvert('launchpad', (v) => v as String?),
          cores: $checkedConvert(
              'cores',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => LaunchCore.fromJson(e as Map<String, dynamic>))
                  .toList()),
          links: $checkedConvert(
              'links',
              (v) => v == null
                  ? null
                  : LaunchLinks.fromJson(v as Map<String, dynamic>)),
          autoUpdate: $checkedConvert('auto_update', (v) => v as bool?),
        );
        return val;
      },
      fieldKeyMap: const {
        'launchLibraryId': 'launch_library_id',
        'flightNumber': 'flight_number',
        'dateUtc': 'date_utc',
        'dateLocal': 'date_local',
        'datePrecision': 'date_precision',
        'staticFireDateUtc': 'static_fire_date_utc',
        'autoUpdate': 'auto_update'
      },
    );

Map<String, dynamic> _$LaunchToJson(Launch instance) => <String, dynamic>{
      'id': instance.id,
      'launch_library_id': instance.launchLibraryId,
      'flight_number': instance.flightNumber,
      'name': instance.name,
      'date_utc': instance.dateUtc?.toIso8601String(),
      'date_local': instance.dateLocal?.toIso8601String(),
      'date_precision': _$DateTimePrecisionEnumMap[instance.datePrecision],
      'static_fire_date_utc': instance.staticFireDateUtc?.toIso8601String(),
      'tbd': instance.tbd,
      'net': instance.net,
      'window': instance.window,
      'rocket': instance.rocket,
      'success': instance.success,
      'failures': instance.failures?.map((e) => e.toJson()).toList(),
      'upcoming': instance.upcoming,
      'details': instance.details,
      'fairings': instance.fairings?.toJson(),
      'crew': instance.crew?.map((e) => e.toJson()).toList(),
      'ships': instance.ships,
      'capsules': instance.capsules,
      'payloads': instance.payloads,
      'launchpad': instance.launchpad,
      'cores': instance.cores?.map((e) => e.toJson()).toList(),
      'links': instance.links?.toJson(),
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
          crew: $checkedConvert('crew', (v) => v as String),
          role: $checkedConvert('role', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$LaunchCrewMemberToJson(LaunchCrewMember instance) =>
    <String, dynamic>{
      'crew': instance.crew,
      'role': instance.role,
    };

LaunchCore _$LaunchCoreFromJson(Map<String, dynamic> json) => $checkedCreate(
      'LaunchCore',
      json,
      ($checkedConvert) {
        final val = LaunchCore(
          core: $checkedConvert('core', (v) => v as String),
          flight: $checkedConvert('flight', (v) => v as int?),
          gridfins: $checkedConvert('gridfins', (v) => v as bool?),
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
        'landingAttempt': 'landing_attempt',
        'landingSuccess': 'landing_success',
        'landingType': 'landing_type'
      },
    );

Map<String, dynamic> _$LaunchCoreToJson(LaunchCore instance) =>
    <String, dynamic>{
      'core': instance.core,
      'flight': instance.flight,
      'gridfins': instance.gridfins,
      'legs': instance.legs,
      'reused': instance.reused,
      'landing_attempt': instance.landingAttempt,
      'landing_success': instance.landingSuccess,
      'landing_type': instance.landingType,
      'landpad': instance.landpad,
    };

LaunchLinks _$LaunchLinksFromJson(Map<String, dynamic> json) => $checkedCreate(
      'LaunchLinks',
      json,
      ($checkedConvert) {
        final val = LaunchLinks(
          patch: $checkedConvert(
              'patch',
              (v) => v == null
                  ? null
                  : PatchLinks.fromJson(v as Map<String, dynamic>)),
          reddit: $checkedConvert(
              'reddit',
              (v) => v == null
                  ? null
                  : RedditLaunchLinks.fromJson(v as Map<String, dynamic>)),
          flickr: $checkedConvert(
              'flickr',
              (v) => v == null
                  ? null
                  : FlickrLaunchLinks.fromJson(v as Map<String, dynamic>)),
          presskit: $checkedConvert('presskit', (v) => v as String?),
          webcast: $checkedConvert('webcast', (v) => v as String?),
          youtubeId: $checkedConvert('youtube_id', (v) => v as String?),
          article: $checkedConvert('article', (v) => v as String?),
          wikipedia: $checkedConvert('wikipedia', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {'youtubeId': 'youtube_id'},
    );

Map<String, dynamic> _$LaunchLinksToJson(LaunchLinks instance) =>
    <String, dynamic>{
      'patch': instance.patch?.toJson(),
      'reddit': instance.reddit?.toJson(),
      'flickr': instance.flickr?.toJson(),
      'presskit': instance.presskit,
      'webcast': instance.webcast,
      'youtube_id': instance.youtubeId,
      'article': instance.article,
      'wikipedia': instance.wikipedia,
    };

PatchLinks _$PatchLinksFromJson(Map<String, dynamic> json) => $checkedCreate(
      'PatchLinks',
      json,
      ($checkedConvert) {
        final val = PatchLinks(
          small: $checkedConvert('small', (v) => v as String?),
          large: $checkedConvert('large', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$PatchLinksToJson(PatchLinks instance) =>
    <String, dynamic>{
      'small': instance.small,
      'large': instance.large,
    };

RedditLaunchLinks _$RedditLaunchLinksFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'RedditLaunchLinks',
      json,
      ($checkedConvert) {
        final val = RedditLaunchLinks(
          campaign: $checkedConvert('campaign', (v) => v as String?),
          launch: $checkedConvert('launch', (v) => v as String?),
          media: $checkedConvert('media', (v) => v as String?),
          recovery: $checkedConvert('recovery', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$RedditLaunchLinksToJson(RedditLaunchLinks instance) =>
    <String, dynamic>{
      'campaign': instance.campaign,
      'launch': instance.launch,
      'media': instance.media,
      'recovery': instance.recovery,
    };

FlickrLaunchLinks _$FlickrLaunchLinksFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'FlickrLaunchLinks',
      json,
      ($checkedConvert) {
        final val = FlickrLaunchLinks(
          small: $checkedConvert('small',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
          original: $checkedConvert('original',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$FlickrLaunchLinksToJson(FlickrLaunchLinks instance) =>
    <String, dynamic>{
      'small': instance.small,
      'original': instance.original,
    };
