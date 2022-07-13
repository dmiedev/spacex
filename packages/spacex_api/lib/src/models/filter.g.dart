// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextFilterParameters _$TextFilterParametersFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'TextFilterParameters',
      json,
      ($checkedConvert) {
        final val = TextFilterParameters(
          search: $checkedConvert(r'$search', (v) => v as String),
          language: $checkedConvert(r'$language', (v) => v as String?),
          caseSensitive:
              $checkedConvert(r'$caseSensitive', (v) => v as bool? ?? false),
          diacriticSensitive: $checkedConvert(
              r'$diacriticSensitive', (v) => v as bool? ?? false),
        );
        return val;
      },
      fieldKeyMap: const {
        'search': r'$search',
        'language': r'$language',
        'caseSensitive': r'$caseSensitive',
        'diacriticSensitive': r'$diacriticSensitive'
      },
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
  val[r'$caseSensitive'] = instance.caseSensitive;
  val[r'$diacriticSensitive'] = instance.diacriticSensitive;
  return val;
}
