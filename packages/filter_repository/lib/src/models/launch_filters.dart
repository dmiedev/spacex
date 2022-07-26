import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'launch_filters.g.dart';

/// The time of a launch.
@HiveType(typeId: 0)
enum LaunchTime {
  /// Represents launches that happened in the past.
  @HiveField(0)
  past,

  /// Represents launches that are going to happen in the future.
  @HiveField(1)
  upcoming
}

/// Launch successfulness.
@HiveType(typeId: 1)
enum LaunchSuccessfulness {
  /// Represents launches with any successfulness.
  @HiveField(0, defaultValue: true)
  any,

  /// Represents successful launches.
  @HiveField(1)
  success,

  /// Represents failed launches.
  @HiveField(2)
  failure
}

/// A collection of filters used to match rocket launches.
@HiveType(typeId: 2)
class LaunchFilters extends Equatable {
  /// Creates a collection of filters used to match rocket launches.
  const LaunchFilters({
    this.time,
    this.fromDate,
    this.toDate,
    this.flightNumber,
    this.successfulness,
    this.rocketIds,
  });

  /// Whether launches should be past or upcoming.
  @HiveField(0)
  final LaunchTime? time;

  /// The date after which launches should be.
  @HiveField(1)
  final DateTime? fromDate;

  /// The date before which launches should be.
  @HiveField(2)
  final DateTime? toDate;

  /// The flight number launches should have.
  @HiveField(3)
  final int? flightNumber;

  /// The successfulness launches should have.
  @HiveField(4)
  final LaunchSuccessfulness? successfulness;

  /// IDs of rockets launches should relate to.
  @HiveField(5)
  final List<int>? rocketIds;

  @override
  List<Object?> get props => [
        time,
        fromDate,
        toDate,
        flightNumber,
        successfulness,
        rocketIds,
      ];
}
