// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Page<T> _$PageFromJson<T>(Map<String, dynamic> json) => $checkedCreate(
      'Page',
      json,
      ($checkedConvert) {
        final val = Page<T>(
          docs: $checkedConvert(
              'docs',
              (v) => (v as List<dynamic>)
                  .map((e) => _PageDocsJsonConverter<T>()
                      .fromJson(e as Map<String, dynamic>))
                  .toList()),
          totalDocs: $checkedConvert('totalDocs', (v) => v as int),
          offset: $checkedConvert('offset', (v) => v as int?),
          limit: $checkedConvert('limit', (v) => v as int),
          totalPages: $checkedConvert('totalPages', (v) => v as int),
          page: $checkedConvert('page', (v) => v as int),
          pagingCounter: $checkedConvert('pagingCounter', (v) => v as int),
          hasPrevPage: $checkedConvert('hasPrevPage', (v) => v as bool),
          hasNextPage: $checkedConvert('hasNextPage', (v) => v as bool),
          prevPage: $checkedConvert('prevPage', (v) => v as int?),
          nextPage: $checkedConvert('nextPage', (v) => v as int?),
        );
        return val;
      },
    );

Map<String, dynamic> _$PageToJson<T>(Page<T> instance) => <String, dynamic>{
      'docs': instance.docs.map(_PageDocsJsonConverter<T>().toJson).toList(),
      'totalDocs': instance.totalDocs,
      'offset': instance.offset,
      'limit': instance.limit,
      'totalPages': instance.totalPages,
      'page': instance.page,
      'pagingCounter': instance.pagingCounter,
      'hasPrevPage': instance.hasPrevPage,
      'hasNextPage': instance.hasNextPage,
      'prevPage': instance.prevPage,
      'nextPage': instance.nextPage,
    };
