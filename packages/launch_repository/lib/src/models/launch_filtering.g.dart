// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch_filtering.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaunchFiltering _$LaunchFilteringFromJson(Map<String, dynamic> json) =>
    LaunchFiltering(
      searchedPhrase: json['searchedPhrase'] as String? ?? '',
      time: $enumDecodeNullable(_$LaunchTimeEnumMap, json['time']) ??
          LaunchTime.upcoming,
      flightNumber: json['flightNumber'] as int?,
      dateInterval: json['dateInterval'] == null
          ? null
          : DateTimeInterval.fromJson(
              json['dateInterval'] as Map<String, dynamic>),
      successfulness: $enumDecodeNullable(
              _$LaunchSuccessfulnessEnumMap, json['successfulness']) ??
          LaunchSuccessfulness.any,
      rocketIds: (json['rocketIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$LaunchFilteringToJson(LaunchFiltering instance) =>
    <String, dynamic>{
      'searchedPhrase': instance.searchedPhrase,
      'time': _$LaunchTimeEnumMap[instance.time],
      'flightNumber': instance.flightNumber,
      'dateInterval': instance.dateInterval,
      'successfulness': _$LaunchSuccessfulnessEnumMap[instance.successfulness]!,
      'rocketIds': instance.rocketIds,
    };

const _$LaunchTimeEnumMap = {
  LaunchTime.past: 'past',
  LaunchTime.upcoming: 'upcoming',
};

const _$LaunchSuccessfulnessEnumMap = {
  LaunchSuccessfulness.any: 'any',
  LaunchSuccessfulness.success: 'success',
  LaunchSuccessfulness.failure: 'failure',
};
