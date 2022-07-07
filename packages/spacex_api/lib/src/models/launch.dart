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

  final LaunchFairings? fairings;

  /// A collection of links to various content.
  final LaunchLinks links;

  /// The date of a static fire test.
  @JsonKey(name: 'static_fire_date_utc')
  final DateTime? staticFireDate;

  final bool net;

  final int? window;

  final String rocket;

  final bool? success;

  final List<LaunchFailure> failures;

  final String? details;

  final List<LaunchCrewMember> crew;

  final List<String> ships;

  final List<String> capsules;

  final List<String> payloads;

  final String launchpad;

  final int flightNumber;

  final String name;

  final DateTime dateUtc;

  final DateTime dateLocal;

  final String datePrecision;

  final bool upcoming;

  final List<LaunchCore> cores;

  final bool autoUpdate;

  final bool tbd;

  final String? launchLibraryId;

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

@JsonSerializable(fieldRename: FieldRename.snake)
class LaunchFairings extends Equatable {
  const LaunchFairings({
    this.reused,
    this.recoveryAttempt,
    this.recovered,
    required this.ships,
  });

  final bool? reused;

  final bool? recoveryAttempt;

  final bool? recovered;

  final List<String> ships;

  @override
  List<Object?> get props => [reused, recoveryAttempt, recovered, ships];
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LaunchFailure extends Equatable {
  const LaunchFailure({
    this.time,
    this.altitude,
    this.reason,
  });

  final int? time;

  final int? altitude;

  final String? reason;

  @override
  List<Object?> get props => [time, altitude, reason];
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LaunchCrewMember extends Equatable {
  const LaunchCrewMember({
    required this.id,
    required this.role,
  });

  @JsonKey(name: 'crew')
  final String id;

  final String role;

  @override
  List<Object?> get props => [id, role];
}

@JsonSerializable(fieldRename: FieldRename.snake)
class LaunchCore extends Equatable {
  const LaunchCore({
    this.id,
    this.flight,
    this.gridfins,
    this.legs,
    this.reused,
    this.landingAttempt,
    this.landingSuccess,
    this.landingType,
    this.landpad,
  });

  @JsonKey(name: 'core')
  final String? id;

  final int? flight;

  final bool? gridfins;

  final bool? legs;

  final bool? reused;

  final bool? landingAttempt;

  final bool? landingSuccess;

  final String? landingType;

  final String? landpad;

  @override
  List<Object?> get props => [
        id,
        flight,
        gridfins,
        legs,
        reused,
        landingAttempt,
        landingSuccess,
        landingType,
        landpad,
      ];
}
