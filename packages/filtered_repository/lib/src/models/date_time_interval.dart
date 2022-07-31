import 'package:equatable/equatable.dart';

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
