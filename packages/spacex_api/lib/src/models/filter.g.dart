// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextFilterParameters _$TextFilterParametersFromJson(
        Map<String, dynamic> json) =>
    TextFilterParameters(
      search: json[r'$search'] as String,
      language: json[r'$language'] as String?,
      caseSensitive: json[r'$caseSensitive'] as bool?,
      diacriticSensitive: json[r'$diacriticSensitive'] as bool?,
    );

Map<String, dynamic> _$TextFilterParametersToJson(
    TextFilterParameters instance) {
  final val = <String, dynamic>{
    r'$search': instance.search,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(r'$language', instance.language);
  writeNotNull(r'$caseSensitive', instance.caseSensitive);
  writeNotNull(r'$diacriticSensitive', instance.diacriticSensitive);
  return val;
}
