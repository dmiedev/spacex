import 'package:filtered_repository/filtered_repository.dart';

enum LaunchSortingParameter implements SortingParameter {
  date,
  name,
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
