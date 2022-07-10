// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Page<T> _$PageFromJson<T>(Map<String, dynamic> json) => Page<T>(
      docs: (json['docs'] as List<dynamic>)
          .map((e) =>
              _PageDocsJsonConverter<T>().fromJson(e as Map<String, dynamic>))
          .toList(),
      totalDocs: json['totalDocs'] as int,
      offset: json['offset'] as int,
      limit: json['limit'] as int,
      totalPages: json['totalPages'] as int,
      page: json['page'] as int,
      pagingCounter: json['pagingCounter'] as int,
      hasPrevPage: json['hasPrevPage'] as bool,
      hasNextPage: json['hasNextPage'] as bool,
      prevPage: json['prevPage'] as int?,
      nextPage: json['nextPage'] as int?,
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
