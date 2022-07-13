import 'package:equatable/equatable.dart';
import 'package:launch_repository/src/models/launch_feature.dart';
import 'package:spacex_api/spacex_api.dart';

/// A type of filtering.
enum FilteringType {
  /// A filtering that matches a specific value.
  value,

  /// A filtering that matches multiple values simultaneously.
  anyFromValues,

  /// A filtering that matches all dates in a specific interval.
  dateTimeInterval,
}

/// An interval between two [DateTime] instances.
class DateTimeInterval extends Equatable {
  /// Creates an interval between two [DateTime] instances.
  ///
  /// The [from] parameter must be a [DateTime] before the [DateTime]
  /// represented by the [to] parameter.
  DateTimeInterval({
    required this.from,
    required this.to,
  }) : assert(from.isBefore(to), '"from" must be before "to"');

  /// The start of this interval.
  final DateTime from;

  /// The end of this interval.
  final DateTime to;

  @override
  List<Object?> get props => [from, to];
}

/// A filtering option to be used for fetching launches.
class FilteringOption extends Equatable {
  /// Creates a filtering option that matches launches with the [feature] equal
  /// to the specified [value].
  const FilteringOption.value({
    required this.feature,
    required this.value,
  }) : type = FilteringType.value;

  /// Creates a filtering option that matches launches with the [feature] equal
  /// to any of the specified [values].
  const FilteringOption.anyFromValues({
    required this.feature,
    required List<Object> values,
  })  : value = values,
        type = FilteringType.anyFromValues;

  /// Creates a filtering option that matches launches with the date-related
  /// [feature] in the specified [interval].
  const FilteringOption.interval({
    required this.feature,
    required DateTimeInterval interval,
  })  : value = interval,
        type = FilteringType.dateTimeInterval;

  /// The type of this filtering option.
  final FilteringType type;

  /// A launch feature this filtering option relates to.
  final LaunchFeature feature;

  /// The value this filtering option should match.
  final Object value;

  /// Converts this [FilteringOption] instance into a [Filter] instance.
  Filter toFilter() {
    final fieldName = feature.toFieldName();
    switch (type) {
      case FilteringType.value:
        return Filter.equal(fieldName, value);
      case FilteringType.anyFromValues:
        return Filter.in_(fieldName, value as List<Object>);
      case FilteringType.dateTimeInterval:
        final interval = value as DateTimeInterval;
        return Filter.and([
          Filter.greaterThanOrEqual(fieldName, interval.from),
          Filter.lessThanOrEqual(fieldName, interval.to),
        ]);
    }
  }

  @override
  List<Object?> get props => [feature, value, type];
}
