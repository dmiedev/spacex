import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'date_time_interval.g.dart';

/// An interval between two [DateTime] instances.
@JsonSerializable()
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

  /// Converts a given JSON [Map] into a [DateTimeInterval] instance.
  static DateTimeInterval fromJson(Map<String, dynamic> json) {
    return _$DateTimeIntervalFromJson(json);
  }

  /// Converts this [DateTimeInterval] instance into a JSON [Map].
  Map<String, dynamic> toJson() => _$DateTimeIntervalToJson(this);

  @override
  List<Object?> get props => [from, to];
}
