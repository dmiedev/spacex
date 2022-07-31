// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch_sorting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaunchSorting _$LaunchSortingFromJson(Map<String, dynamic> json) =>
    LaunchSorting(
      parameter:
          $enumDecode(_$LaunchSortingParameterEnumMap, json['parameter']),
      order: $enumDecode(_$SortOrderEnumMap, json['order']),
    );

Map<String, dynamic> _$LaunchSortingToJson(LaunchSorting instance) =>
    <String, dynamic>{
      'parameter': _$LaunchSortingParameterEnumMap[instance.parameter]!,
      'order': _$SortOrderEnumMap[instance.order]!,
    };

const _$LaunchSortingParameterEnumMap = {
  LaunchSortingParameter.date: 'date',
  LaunchSortingParameter.name: 'name',
  LaunchSortingParameter.flightNumber: 'flightNumber',
};

const _$SortOrderEnumMap = {
  SortOrder.ascending: 'ascending',
  SortOrder.descending: 'descending',
};
