// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationOptions _$PaginationOptionsFromJson(Map<String, dynamic> json) =>
    PaginationOptions(
      select:
          (json['select'] as List<dynamic>?)?.map((e) => e as String).toList(),
      sort: (json['sort'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, $enumDecode(_$SortOrderEnumMap, e)),
      ),
      offset: json['offset'] as int?,
      page: json['page'] as int?,
      limit: json['limit'] as int?,
      pagination: json['pagination'] as bool?,
      populate: (json['populate'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
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
