import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:spacex_api/src/models/launch_links.dart';

/// A launch of a rocket at SpaceX.
@JsonSerializable(fieldRename: FieldRename.snake)
class Launch extends Equatable {
  /// Creates a model containing information about a launch of a rocket at
  /// SpaceX.
  const Launch({
    this.fairings,
    required this.links,
    this.staticFireDate,
    required this.net,
    this.window,
    required this.rocket,
    this.success,
    required this.failures,
    this.details,
    required this.crew,
    required this.ships,
    required this.capsules,
    required this.payloads,
    required this.launchpad,
    required this.flightNumber,
    required this.name,
    required this.dateUtc,
    required this.dateLocal,
    required this.datePrecision,
    required this.upcoming,
    required this.cores,
    required this.autoUpdate,
    required this.tbd,
    this.launchLibraryId,
    required this.id,
  });

  /// Data on the recovery of fairings used on the rocket during this launch.
  final LaunchFairingsRecovery? fairings;

  /// A collection of links to various content.
  final LaunchLinks links;

  /// The date of a static fire test.
  @JsonKey(name: 'static_fire_date_utc')
  final DateTime? staticFireDate;

  /// Whether the date of this launch should be interpreted as "Not earlier
  /// than".
  final bool net;

  /// The duration of the launch window in seconds.
  final int? window;

  /// The ID of the rocket involved in this launch.
  final String rocket;

  /// Whether this launch was successful.
  final bool? success;

  /// A list of failures that occurred during this launch.
  final List<LaunchFailure> failures;

  /// Detailed information about this launch.
  final String? details;

  /// The crew that participates in this launch.
  final List<LaunchCrewMember> crew;

  /// The IDs of the ships that caught the rocket first-stages after this
  /// launch.
  final List<String> ships;

  /// The IDs of the Dragon capsules that the rocket of this launch holds.
  final List<String> capsules;

  /// The IDs of the payloads that the rocket of this launch holds.
  final List<String> payloads;

  /// The ID of the launchpad that this launch happens on.
  final String launchpad;

  /// The serial number of the launch.
  final int flightNumber;

  /// The name of this launch.
  final String name;

  /// The UTC date and time of this launch.
  final DateTime dateUtc;

  /// The local date and time of this launch.
  final DateTime dateLocal;

  /// The precision of the date of this launch.
  final DateTimePrecision datePrecision;

  /// Whether this launch is upcoming.
  final bool upcoming;

  /// A list of cores used for the rocket of this launch.
  final List<LaunchCore> cores;

  /// Whether this launch provides automatic updates on its course.
  final bool autoUpdate;

  /// Whether the date of this launch is yet to be determined.
  final bool tbd;

  /// The ID of this launch in the launch library.
  final String? launchLibraryId;

  /// The ID of this launch.
  final String id;

  @override
  List<Object?> get props => [
        fairings,
        links,
        staticFireDate,
        net,
        window,
        rocket,
        success,
        failures,
        details,
        crew,
        ships,
        capsules,
        payloads,
        launchpad,
        flightNumber,
        name,
        dateUtc,
        dateLocal,
        datePrecision,
        upcoming,
        cores,
        autoUpdate,
        tbd,
        launchLibraryId,
        id,
      ];
}

/// The precision of a [DateTime] object.
enum DateTimePrecision {
  /// Quarter [DateTime] precision.
  quarter,

  /// Half-year [DateTime] precision.
  half,

  /// Year [DateTime] precision.
  year,

  /// Month [DateTime] precision.
  month,

  /// Day [DateTime] precision.
  day,

  /// Hour [DateTime] precision.
  hour,
}

/// Information on the recovery of fairings used on a rocket during its launch.
@JsonSerializable(fieldRename: FieldRename.snake)
class LaunchFairingsRecovery extends Equatable {
  /// Creates a model that contains data about the recovery of fairings used on
  /// a rocket during its launch.
  const LaunchFairingsRecovery({
    this.reused,
    this.recoveryAttempt,
    this.recovered,
    required this.ships,
  });

  /// Whether these fairings were reused.
  final bool? reused;

  /// Whether there was an attempt to recover these fairings.
  final bool? recoveryAttempt;

  /// Whether these fairings were recovered.
  final bool? recovered;

  /// The IDs of the ships that were involved in the recovery of these fairings.
  final List<String> ships;

  @override
  List<Object?> get props => [reused, recoveryAttempt, recovered, ships];
}

/// A failure that occurred during a launch of a rocket.
@JsonSerializable(fieldRename: FieldRename.snake)
class LaunchFailure extends Equatable {
  /// Creates a model that contains data about a failure that occurred during
  /// a launch of a rocket.
  const LaunchFailure({
    this.time,
    this.altitude,
    this.reason,
  });

  /// Time since launch in seconds this failure occurred.
  final int? time;

  /// The altitude of the rocket in kilometers when this failure occurred.
  final int? altitude;

  /// The reason of this failure.
  final String? reason;

  @override
  List<Object?> get props => [time, altitude, reason];
}

/// A crew member involved in a rocket launch.
@JsonSerializable(fieldRename: FieldRename.snake)
class LaunchCrewMember extends Equatable {
  /// Creates a model of a crew member involved in a rocket launch.
  const LaunchCrewMember({
    required this.id,
    required this.role,
  });

  /// The ID of this crew member.
  @JsonKey(name: 'crew')
  final String id;

  /// The role name of this crew member.
  final String role;

  @override
  List<Object?> get props => [id, role];
}

/// A core that is being used in a rocket launch.
@JsonSerializable(fieldRename: FieldRename.snake)
class LaunchCore extends Equatable {
  /// Creates a model that holds data about a core used in a rocket launch.
  const LaunchCore({
    this.id,
    this.flight,
    this.gridFins,
    this.legs,
    this.reused,
    this.landingAttempt,
    this.landingSuccess,
    this.landingType,
    this.landpad,
  });

  /// The ID of this core.
  @JsonKey(name: 'core')
  final String? id;

  /// The number of this core's flight.
  final int? flight;

  /// Whether this core has grid fins.
  @JsonKey(name: 'gridfins')
  final bool? gridFins;

  /// Whether this core has legs.
  final bool? legs;

  /// Whether this core is reused.
  final bool? reused;

  /// Whether there was a landing attempt of this core.
  final bool? landingAttempt;

  /// Whether this core has landed successfully.
  final bool? landingSuccess;

  /// The type of the landing of this core.
  final String? landingType;

  /// The ID of the landing pad that this core has landed on.
  final String? landpad;

  @override
  List<Object?> get props => [
        id,
        flight,
        gridFins,
        legs,
        reused,
        landingAttempt,
        landingSuccess,
        landingType,
        landpad,
      ];
}
