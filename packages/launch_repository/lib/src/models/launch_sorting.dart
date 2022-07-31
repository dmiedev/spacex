import 'package:filtered_repository/filtered_repository.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:spacex_api/spacex_api.dart';

part 'launch_sorting.g.dart';

/// A parameter for sorting rocket launches.
enum LaunchSortingParameter implements SortingParameter {
  /// Launch date.
  date,

  /// Launch name.
  name,

  /// Launch flight number.
  flightNumber;

  @override
  String toFieldName() {
    switch (this) {
      case date:
        return 'date_utc';
      case name:
        return 'name';
      case flightNumber:
        return 'flight_number';
    }
  }
}

/// Options used to sort [Launch] objects.
@JsonSerializable()
class LaunchSorting extends Sorting<LaunchSortingParameter> {
  /// Creates options used to sort [Launch] objects.
  const LaunchSorting({
    required super.parameter,
    required super.order,
  });

  /// Converts a given JSON [Map] into a [LaunchSorting] instance.
  static LaunchSorting fromJson(Map<String, dynamic> json) {
    return _$LaunchSortingFromJson(json);
  }

  /// Converts this [LaunchSorting] instance into a JSON [Map].
  Map<String, dynamic> toJson() => _$LaunchSortingToJson(this);
}
