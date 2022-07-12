// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationOptions _$PaginationOptionsFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PaginationOptions',
      json,
      ($checkedConvert) {
        final val = PaginationOptions(
          select: $checkedConvert('select',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
          sort: $checkedConvert(
              'sort',
              (v) => (v as Map<String, dynamic>?)?.map(
                    (k, e) => MapEntry(k, $enumDecode(_$SortOrderEnumMap, e)),
                  )),
          offset: $checkedConvert('offset', (v) => v as int?),
          page: $checkedConvert('page', (v) => v as int?),
          limit: $checkedConvert('limit', (v) => v as int?),
          pagination: $checkedConvert('pagination', (v) => v as bool?),
          populate: $checkedConvert('populate',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$PaginationOptionsToJson(PaginationOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('select', instance.select);
  writeNotNull(
      'sort', instance.sort?.map((k, e) => MapEntry(k, _$SortOrderEnumMap[e])));
  writeNotNull('offset', instance.offset);
  writeNotNull('page', instance.page);
  writeNotNull('limit', instance.limit);
  writeNotNull('pagination', instance.pagination);
  writeNotNull('populate', instance.populate);
  return val;
}

const _$SortOrderEnumMap = {
  SortOrder.ascending: 'ascending',
  SortOrder.descending: 'descending',
};
