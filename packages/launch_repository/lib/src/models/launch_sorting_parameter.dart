import 'package:filtered_repository/filtered_repository.dart';

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
