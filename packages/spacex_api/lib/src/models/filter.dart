import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'filter.g.dart';

/// An operator that can be applied to a filter.
enum FilterOperator {
  /// Matches values that are equal to a specified value.
  equal,

  /// Matches values that are greater than a specified value.
  greaterThan,

  /// Matches values that are greater than or equal to a specified value.
  greaterThanOrEqual,

  /// Matches any of the values specified in an array.
  in_,

  /// Matches values that are less than a specified value.
  lessThan,

  /// Matches values that are less than or equal to a specified value.
  lessThanOrEqual,

  /// Matches all values that are not equal to a specified value.
  notEqual,

  /// Matches none of the values specified in an array.
  notIn,

  /// Joins filters with a logical `AND`.
  and,

  /// Joins filters with a logical `NOR`.
  nor,

  /// Joins filters with a logical `OR`.
  or,

  /// Matches documents that have the specified field.
  exists,

  /// Performs text search.
  text;

  @override
  String toString() {
    switch (this) {
      case FilterOperator.equal:
        return r'$eq';
      case FilterOperator.greaterThan:
        return r'$gt';
      case FilterOperator.greaterThanOrEqual:
        return r'$gte';
      case FilterOperator.in_:
        return r'$in';
      case FilterOperator.lessThan:
        return r'$lt';
      case FilterOperator.lessThanOrEqual:
        return r'$lte';
      case FilterOperator.notEqual:
        return r'$ne';
      case FilterOperator.notIn:
        return r'$nin';
      case FilterOperator.and:
        return r'$and';
      case FilterOperator.nor:
        return r'$nor';
      case FilterOperator.or:
        return r'$or';
      case FilterOperator.exists:
        return r'$exists';
      case FilterOperator.text:
        return r'$text';
    }
  }
}

const _groupOperators = [
  FilterOperator.and,
  FilterOperator.nor,
  FilterOperator.or,
];

/// A filter used for narrowing down queried documents.
class Filter extends Equatable {
  const Filter.__({
    this.operator,
    this.field,
    required this.value,
  });

  const Filter._(
    FilterOperator operator, {
    this.field,
    required this.value,
  }) : operator = '$operator';

  /// Creates an empty filter.
  const Filter.empty()
      : operator = null,
        field = null,
        value = const <String, dynamic>{};

  /// Creates a filter that matches values that are equal to a specified value.
  ///
  /// The [field] parameter must be the name of a field in `snake_case`.
  /// The [value] parameter must be a value that this filter should match.
  factory Filter.equal(String field, Object value) {
    return Filter._(FilterOperator.equal, field: field, value: value);
  }

  /// Creates a filter that matches values that are greater than a specified
  /// value.
  ///
  /// The [field] parameter must be the name of a field in `snake_case`.
  /// The [value] parameter must be a value that this filter should match.
  factory Filter.greaterThan(String field, Object value) {
    return Filter._(FilterOperator.greaterThan, field: field, value: value);
  }

  /// Creates a filter that matches values that are greater than or equal to a
  /// specified value.
  ///
  /// The [field] parameter must be the name of a field in `snake_case`.
  /// The [value] parameter must be a value that this filter should match.
  factory Filter.greaterThanOrEqual(String field, Object value) {
    return Filter._(
      FilterOperator.greaterThanOrEqual,
      field: field,
      value: value,
    );
  }

  /// Creates a filter that matches any of the values specified in an array.
  ///
  /// The [field] parameter must be the name of a field in `snake_case`.
  /// The [values] parameter must be a nonempty array of values that this filter
  /// should match.
  factory Filter.in_(String field, List<Object> values) {
    assert(values.isNotEmpty, '"values" must be a nonempty array!');
    return Filter._(FilterOperator.in_, field: field, value: values);
  }

  /// Creates a filter that matches values that are less than a specified value.
  ///
  /// The [field] parameter must be the name of a field in `snake_case`.
  /// The [value] parameter must be a value that this filter should match.
  factory Filter.lessThan(String field, Object value) {
    return Filter._(FilterOperator.lessThan, field: field, value: value);
  }

  /// Creates a filter that matches values that are less than or equal to a
  /// specified value.
  ///
  /// The [field] parameter must be the name of a field in `snake_case`.
  /// The [value] parameter must be a value that this filter should match.
  factory Filter.lessThanOrEqual(String field, Object value) {
    return Filter._(FilterOperator.lessThanOrEqual, field: field, value: value);
  }

  /// Creates a filter that matches all values that are not equal to a specified
  /// value.
  ///
  /// The [field] parameter must be the name of a field in `snake_case`.
  /// The [value] parameter must be a value that this filter should match.
  factory Filter.notEqual(String field, Object value) {
    return Filter._(FilterOperator.notEqual, field: field, value: value);
  }

  /// Creates a filter that matches none of the values specified in an array.
  ///
  /// The [field] parameter must be the name of a field in `snake_case`.
  /// The [values] parameter must be a nonempty array of values that this filter
  /// should match.
  factory Filter.notIn(String field, List<Object> values) {
    assert(values.isNotEmpty, '"values" must be a nonempty array!');
    return Filter._(FilterOperator.notIn, field: field, value: values);
  }

  /// Creates a filter that joins [filters] with a logical `AND`.
  ///
  /// The [filters] parameter must be a nonempty array.
  factory Filter.and(List<Filter> filters) {
    assert(filters.isNotEmpty, '"filters" must be a nonempty array!');
    return Filter._(FilterOperator.and, value: filters);
  }

  /// Creates a filter that joins [filters] with a logical `NOR`.
  ///
  /// The [filters] parameter must be a nonempty array.
  factory Filter.nor(List<Filter> filters) {
    assert(filters.isNotEmpty, '"filters" must be a nonempty array!');
    return Filter._(FilterOperator.nor, value: filters);
  }

  /// Creates a filter that joins [filters] with a logical `OR`.
  ///
  /// The [filters] parameter must be a nonempty array.
  factory Filter.or(List<Filter> filters) {
    assert(filters.isNotEmpty, '"filters" must be a nonempty array!');
    return Filter._(FilterOperator.or, value: filters);
  }

  /// Creates a filter that matches documents that have (or don't have) the
  /// specified field.
  ///
  /// The [field] parameter must be the name of a field in `snake_case`.
  factory Filter.exists(String field, {bool exists = true}) {
    return Filter._(FilterOperator.exists, field: field, value: exists);
  }

  /// Creates a filter that performs text search with the given [parameters].
  factory Filter.text(TextFilterParameters parameters) {
    return Filter._(FilterOperator.text, value: parameters);
  }

  /// Creates a custom filter.
  ///
  /// The [operator] argument, if provided, must start with the `$`.
  ///
  /// If [value] is provided as the only argument, it must be a subtype of
  /// `Map<String, dynamic>`.
  const factory Filter.custom({
    String? operator,
    String? field,
    required Object value,
  }) = Filter.__;

  /// An operator to use for this filter.
  ///
  /// Must start with the `$`.
  final String? operator;

  /// The name of a field in `snake_case` to apply this filter on.
  ///
  /// Group operators, such as [FilterOperator.and], [FilterOperator.or] and
  /// [FilterOperator.nor], don't require the field name to be present.
  final String? field;

  /// The value this filter should match.
  final Object value;

  /// Converts this [Filter] instance into a JSON [Map].
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    final groupOperators = _groupOperators.map((operator) => '$operator');
    if (groupOperators.contains(operator)) {
      final filters = value as List<Filter>;
      json[operator!] = filters.map((filter) => filter.toJson()).toList();
    } else if (operator == FilterOperator.text.toString()) {
      final parameters = value as TextFilterParameters;
      json[operator!] = parameters.toJson();
    } else if (operator != null) {
      json[field!] = {operator: value};
    } else if (field != null) {
      json[field!] = value;
    } else if (value is Map<String, dynamic>) {
      return value as Map<String, dynamic>;
    } else {
      throw UnsupportedError(
        'Cannot convert "value" as the only non-null field to '
        'Map<String, dynamic> as it is not a subtype of Map<String, dynamic>.',
      );
    }
    return json;
  }

  @override
  List<Object?> get props => [operator, field, value];
}

/// Parameters used for the text filter.
@JsonSerializable(fieldRename: FieldRename.none, includeIfNull: false)
class TextFilterParameters extends Equatable {
  /// Creates parameters used for the text filter.
  const TextFilterParameters({
    required this.search,
    this.language,
    this.caseSensitive = false,
    this.diacriticSensitive = false,
  });

  /// A string of terms to search for.
  ///
  /// Most punctuation in the string is treated as delimiters.
  ///
  /// To match on a phrase, as opposed to individual terms, consider enclosing
  /// the phrase in double quotes (`"`).
  ///
  /// Prefixing a word with a hyphen-minus (`-`) negates a word.
  @JsonKey(name: r'$search')
  final String search;

  /// The language that determines the list of stop words for the search and the
  /// rules for the stemmer and tokenizer.
  ///
  /// If not specified, the search uses the default language of the index.
  ///
  /// If specified as `none`, the text search uses simple tokenization with no
  /// list of stop words and no stemming.
  @JsonKey(name: r'$language')
  final String? language;

  /// Whether case-sensitive search is enabled.
  ///
  /// Defaults to `false`.
  @JsonKey(name: r'$caseSensitive')
  final bool caseSensitive;

  /// Whether diacritic-sensitive search is enabled.
  ///
  /// Defaults to `false`.
  @JsonKey(name: r'$diacriticSensitive')
  final bool diacriticSensitive;

  /// Converts a given JSON [Map] into a [TextFilterParameters] instance.
  static TextFilterParameters fromJson(Map<String, dynamic> json) {
    return _$TextFilterParametersFromJson(json);
  }

  /// Converts this [TextFilterParameters] instance into a JSON [Map].
  Map<String, dynamic> toJson() => _$TextFilterParametersToJson(this);

  @override
  List<Object?> get props => [
        search,
        language,
        caseSensitive,
        diacriticSensitive,
      ];
}
