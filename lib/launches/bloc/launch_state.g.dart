// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaunchState _$LaunchStateFromJson(Map<String, dynamic> json) => $checkedCreate(
      'LaunchState',
      json,
      ($checkedConvert) {
        final val = LaunchState(
          launches: $checkedConvert(
              'launches',
              (v) => (v as List<dynamic>)
                  .map((e) => Launch.fromJson(e as Map<String, dynamic>))
                  .toList()),
          lastPageNumber: $checkedConvert('lastPageNumber', (v) => v as int),
          lastPageAmount: $checkedConvert('lastPageAmount', (v) => v as int),
          hasReachedEnd:
              $checkedConvert('hasReachedEnd', (v) => v as bool? ?? false),
          errorOccurred:
              $checkedConvert('errorOccurred', (v) => v as bool? ?? false),
        );
        return val;
      },
    );

Map<String, dynamic> _$LaunchStateToJson(LaunchState instance) =>
    <String, dynamic>{
      'launches': instance.launches.map((e) => e.toJson()).toList(),
      'lastPageNumber': instance.lastPageNumber,
      'lastPageAmount': instance.lastPageAmount,
      'hasReachedEnd': instance.hasReachedEnd,
      'errorOccurred': instance.errorOccurred,
    };
