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

@HiveType(typeId: 2)
class LaunchFilters extends Equatable {
  const LaunchFilters({
    this.time,
    this.fromDate,
    this.toDate,
    this.flightNumber,
    this.successfulness,
    this.rocketIds,
  });

  @HiveField(0)
  final LaunchTime? time;

  @HiveField(1)
  final DateTime? fromDate;

  @HiveField(2)
  final DateTime? toDate;

  @HiveField(3)
  final int? flightNumber;

  @HiveField(4)
  final LaunchSuccessfulness? successfulness;

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
