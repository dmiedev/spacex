import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'launch.g.dart';

/// A launch of a rocket at SpaceX.
@JsonSerializable(fieldRename: FieldRename.snake)
class Launch extends Equatable {
  /// Creates a model containing information about a launch of a rocket at
  /// SpaceX.
  const Launch({
    required this.id,
    this.launchLibraryId,
    required this.flightNumber,
    required this.name,
    required this.dateUtc,
    required this.dateLocal,
    required this.datePrecision,
    this.staticFireDateUtc,
    this.tbd = false,
    this.net = false,
    this.window,
    this.rocket,
    this.success,
    this.failures = const [],
    required this.upcoming,
    this.details,
    this.fairings,
    this.crew = const [],
    this.ships = const [],
    this.capsules = const [],
    this.payloads = const [],
    this.launchpad,
    this.cores = const [],
    required this.links,
    this.autoUpdate = true,
  });

  /// The ID of this launch.
  final String id;

  /// The ID of this launch in the launch library.
  final String? launchLibraryId;

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

  /// The date of a static fire test.
  final DateTime? staticFireDateUtc;

  /// Whether the date of this launch is yet to be determined.
  final bool tbd;

  /// Whether the date of this launch should be interpreted as "Not earlier
  /// than".
  final bool net;

  /// The duration of the launch window in seconds.
  final int? window;

  /// The ID of the rocket involved in this launch.
  final String? rocket;

  /// Whether this launch was successful.
  final bool? success;

  /// A list of failures that occurred during this launch.
  final List<LaunchFailure> failures;

  /// Whether this launch is upcoming.
  final bool upcoming;

  /// Detailed information about this launch.
  final String? details;

  /// Data on the recovery of fairings used on the rocket during this launch.
  final LaunchFairingsRecovery? fairings;

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
  final String? launchpad;

  /// A list of cores used for the rocket of this launch.
  final List<LaunchCore> cores;

  /// A collection of links to various content.
  final LaunchLinks links;

  /// Whether this launch provides automatic updates on its course.
  final bool autoUpdate;

  @override
  List<Object?> get props => [
        id,
        launchLibraryId,
        flightNumber,
        name,
        dateUtc,
        dateLocal,
        datePrecision,
        staticFireDateUtc,
        tbd,
        net,
        window,
        rocket,
        success,
        failures,
        upcoming,
        details,
        fairings,
        crew,
        ships,
        capsules,
        payloads,
        launchpad,
        cores,
        links,
        autoUpdate,
      ];

  /// Converts a given JSON [Map] into a [Launch] instance.
  static Launch fromJson(Map<String, dynamic> json) => _$LaunchFromJson(json);

  /// Converts this [Launch] instance into a JSON [Map].
  Map<String, dynamic> toJson() => _$LaunchToJson(this);

  @override
  String toString() => 'Launch($id, $name)';
}

/// The precision of a [DateTime] object.
@JsonEnum(fieldRename: FieldRename.snake)
enum DateTimePrecision {
  /// Half-year [DateTime] precision.
  half,

  /// Quarter [DateTime] precision.
  quarter,

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
    this.ships = const [],
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

  /// Converts a given JSON [Map] into a [LaunchFairingsRecovery] instance.
  static LaunchFairingsRecovery fromJson(Map<String, dynamic> json) {
    return _$LaunchFairingsRecoveryFromJson(json);
  }

  /// Converts this [LaunchFairingsRecovery] instance into a JSON [Map].
  Map<String, dynamic> toJson() => _$LaunchFairingsRecoveryToJson(this);

  @override
  String toString() => 'LaunchFairingsRecovery($recoveryAttempt, $recovered)';
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

  /// Converts a given JSON [Map] into a [LaunchFailure] instance.
  static LaunchFailure fromJson(Map<String, dynamic> json) {
    return _$LaunchFailureFromJson(json);
  }

  /// Converts this [LaunchFailure] instance into a JSON [Map].
  Map<String, dynamic> toJson() => _$LaunchFailureToJson(this);

  @override
  String toString() => 'LaunchFailure($time, $altitude, $reason)';
}

/// A crew member involved in a rocket launch.
@JsonSerializable(fieldRename: FieldRename.snake)
class LaunchCrewMember extends Equatable {
  /// Creates a model of a crew member involved in a rocket launch.
  const LaunchCrewMember({
    this.crew,
    this.role,
  });

  /// The ID of this crew member.
  final String? crew;

  /// The role name of this crew member.
  final String? role;

  @override
  List<Object?> get props => [crew, role];

  /// Converts a given JSON [Map] into a [LaunchCrewMember] instance.
  static LaunchCrewMember fromJson(Map<String, dynamic> json) {
    return _$LaunchCrewMemberFromJson(json);
  }

  /// Converts this [LaunchCrewMember] instance into a JSON [Map].
  Map<String, dynamic> toJson() => _$LaunchCrewMemberToJson(this);

  @override
  String toString() => 'LaunchCrewMember($crew, $role)';
}

/// A core that is being used in a rocket launch.
@JsonSerializable(fieldRename: FieldRename.snake)
class LaunchCore extends Equatable {
  /// Creates a model that holds data about a core used in a rocket launch.
  const LaunchCore({
    this.core,
    this.flight,
    this.gridfins,
    this.legs,
    this.reused,
    this.landingAttempt,
    this.landingSuccess,
    this.landingType,
    this.landpad,
  });

  /// The ID of this core.
  final String? core;

  /// The number of this core's flight.
  final int? flight;

  /// Whether this core has grid fins.
  final bool? gridfins;

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
        core,
        flight,
        gridfins,
        legs,
        reused,
        landingAttempt,
        landingSuccess,
        landingType,
        landpad,
      ];

  /// Converts a given JSON [Map] into a [LaunchCore] instance.
  static LaunchCore fromJson(Map<String, dynamic> json) {
    return _$LaunchCoreFromJson(json);
  }

  /// Converts this [LaunchCore] instance into a JSON [Map].
  Map<String, dynamic> toJson() => _$LaunchCoreToJson(this);

  @override
  String toString() => 'LaunchCore($core, $landingType)';
}

/// A collection of links related to a rocket launch.
@JsonSerializable(fieldRename: FieldRename.snake)
class LaunchLinks extends Equatable {
  /// Creates a collection of links related to a rocket launch.
  const LaunchLinks({
    this.patch = const PatchLinks(),
    this.reddit = const RedditLaunchLinks(),
    required this.flickr,
    this.presskit,
    this.webcast,
    this.youtubeId,
    this.article,
    this.wikipedia,
  });

  /// Links to the patch.
  final PatchLinks patch;

  /// Links to Reddit threads.
  final RedditLaunchLinks reddit;

  /// Links to Flickr images.
  final FlickrLaunchLinks flickr;

  /// A URL to a press kit.
  final String? presskit;

  /// A URL to a webcast.
  final String? webcast;

  /// An ID of a YouTube video.
  final String? youtubeId;

  /// A URL to an article.
  final String? article;

  /// A URL to a Wikipedia article.
  final String? wikipedia;

  @override
  List<Object?> get props => [
        patch,
        reddit,
        flickr,
        presskit,
        webcast,
        youtubeId,
        article,
        wikipedia,
      ];

  /// Converts a given JSON [Map] into a [LaunchLinks] instance.
  static LaunchLinks fromJson(Map<String, dynamic> json) {
    return _$LaunchLinksFromJson(json);
  }

  /// Converts this [LaunchLinks] instance into a JSON [Map].
  Map<String, dynamic> toJson() => _$LaunchLinksToJson(this);
}

/// A collection of links to a launch patch.
@JsonSerializable(fieldRename: FieldRename.snake)
class PatchLinks extends Equatable {
  /// Creates a collection of links to a launch patch.
  const PatchLinks({
    this.small,
    this.large,
  });

  /// A URL to a small-sized image of the patch.
  final String? small;

  /// A URL to a large-sized image of the patch.
  final String? large;

  @override
  List<Object?> get props => [small, large];

  /// Converts a given JSON [Map] into a [PatchLinks] instance.
  static PatchLinks fromJson(Map<String, dynamic> json) {
    return _$PatchLinksFromJson(json);
  }

  /// Converts this [PatchLinks] instance into a JSON [Map].
  Map<String, dynamic> toJson() => _$PatchLinksToJson(this);
}

/// A collection of links to Reddit threads devoted to a rocket launch.
@JsonSerializable(fieldRename: FieldRename.snake)
class RedditLaunchLinks extends Equatable {
  /// Creates a collection of links to Reddit threads devoted to a rocket
  /// launch.
  const RedditLaunchLinks({
    this.campaign,
    this.launch,
    this.media,
    this.recovery,
  });

  /// A URL to a campaign thread.
  final String? campaign;

  /// A URL to a discussion and updates thread.
  final String? launch;

  /// A URL to a media thread.
  final String? media;

  /// A URL to a recovery thread.
  final String? recovery;

  @override
  List<Object?> get props => [campaign, launch, media, recovery];

  /// Converts a given JSON [Map] into a [RedditLaunchLinks] instance.
  static RedditLaunchLinks fromJson(Map<String, dynamic> json) {
    return _$RedditLaunchLinksFromJson(json);
  }

  /// Converts this [RedditLaunchLinks] instance into a JSON [Map].
  Map<String, dynamic> toJson() => _$RedditLaunchLinksToJson(this);
}

/// A collection of links to launch-related images on Flickr.
@JsonSerializable(fieldRename: FieldRename.snake)
class FlickrLaunchLinks extends Equatable {
  /// Creates a collection of links to launch-related images on Flickr.
  const FlickrLaunchLinks({
    required this.small,
    required this.original,
  });

  /// A list of URLs to small-sized images.
  final List<String> small;

  /// A list of URLs to images of original size.
  final List<String> original;

  @override
  List<Object?> get props => [small, original];

  /// Converts a given JSON [Map] into a [FlickrLaunchLinks] instance.
  static FlickrLaunchLinks fromJson(Map<String, dynamic> json) {
    return _$FlickrLaunchLinksFromJson(json);
  }

  /// Converts this [FlickrLaunchLinks] instance into a JSON [Map].
  Map<String, dynamic> toJson() => _$FlickrLaunchLinksToJson(this);
}
