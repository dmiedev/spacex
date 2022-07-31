import 'package:filtered_repository/filtered_repository.dart';
import 'package:spacex_api/spacex_api.dart';

/// A feature of a rocket launch.
enum LaunchFeature implements Feature {
  /// The serial number of the launch.
  flightNumber,

  /// The name of the launch.
  name,

  /// The date and time of the launch.
  date,

  /// Whether the launch is successful.
  isSuccessful,

  /// Whether the launch is upcoming.
  isUpcoming,

  /// The ID of the rocket that is involved in the launch.
  rocketId,

  /// The ID of a Dragon capsule that the rocket of the launch holds.
  capsuleId,

  /// The ID of a payloads that the rocket of the launch holds.
  payloadId,

  /// The ID of the launchpad that the launch happens on.
  launchpadId,

  /// The ID of a ship that catches the rocket first-stages after the launch.
  shipId,

  /// The ID of a core used for the rocket of the launch.
  coreId;

  /// Converts this [LaunchFeature] instance into a [Launch] field name in
  /// `snake_case`.
  @override
  String toFieldName() {
    switch (this) {
      case flightNumber:
        return 'flight_number';
      case name:
        return 'name';
      case date:
        return 'date_utc';
      case isSuccessful:
        return 'success';
      case isUpcoming:
        return 'upcoming';
      case rocketId:
        return 'rocket';
      case capsuleId:
        return 'capsules';
      case payloadId:
        return 'payloads';
      case launchpadId:
        return 'launchpad';
      case shipId:
        return 'ships';
      case coreId:
        return 'cores';
    }
  }
}
