import 'package:equatable/equatable.dart';
import 'package:filtered_repository/filtered_repository.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:spacex_api/spacex_api.dart';

part 'launch_filtering.g.dart';

/// Launch successfulness.
enum LaunchSuccessfulness {
  /// Represents launches with any successfulness.
  any,

  /// Represents successful launches.
  success,

  /// Represents failed launches.
  failure,
}

/// The time of a launch.
enum LaunchTime {
  /// Represents launches that happened in the past.
  past,

  /// Represents launches that are going to happen in the future.
  upcoming,
}

/// A collection of options used to match [Launch] objects.
@JsonSerializable()
class LaunchFiltering extends Equatable implements Filtering {
  /// Creates a collection of options used to match [Launch] objects.
  const LaunchFiltering({
    this.searchedPhrase = '',
    this.time = LaunchTime.upcoming,
    this.flightNumber,
    this.dateInterval,
    this.successfulness = LaunchSuccessfulness.any,
    this.rocketIds = const [],
  });

  /// A phrase to search in String fields of a [Launch].
  final String searchedPhrase;

  /// Whether launches should be past or upcoming.
  final LaunchTime? time;

  /// The flight number launches should have.
  final int? flightNumber;

  /// A date interval in which the launch date should be.
  final DateTimeInterval? dateInterval;

  /// The successfulness launches should have.
  final LaunchSuccessfulness successfulness;

  /// IDs of rockets launches should relate to.
  final List<String> rocketIds;

  @override
  List<Filter> toFilters() {
    return [
      if (searchedPhrase.isNotEmpty)
        Filter.text(TextFilterParameters(search: '"$searchedPhrase"')),
      if (time != null) Filter.equal('upcoming', time == LaunchTime.upcoming),
      if (flightNumber != null) Filter.equal('flight_number', flightNumber!),
      if (dateInterval != null)
        Filter.and([
          Filter.greaterThanOrEqual('date_utc', dateInterval!.from),
          Filter.lessThanOrEqual('date_utc', dateInterval!.to),
        ]),
      if (successfulness != LaunchSuccessfulness.any && time == LaunchTime.past)
        Filter.equal('success', successfulness == LaunchSuccessfulness.success),
      if (rocketIds.isNotEmpty) Filter.in_('rocket', rocketIds),
    ];
  }

  /// Creates a clone of this [LaunchFiltering] instance with the provided
  /// parameters overridden.
  LaunchFiltering copyWith({
    String? searchedPhrase,
    LaunchTime? Function()? time,
    int? Function()? flightNumber,
    DateTimeInterval? Function()? dateInterval,
    LaunchSuccessfulness? successfulness,
    List<String>? rocketIds,
  }) {
    return LaunchFiltering(
      searchedPhrase: searchedPhrase ?? this.searchedPhrase,
      time: time != null ? time() : this.time,
      flightNumber: flightNumber != null ? flightNumber() : this.flightNumber,
      dateInterval: dateInterval != null ? dateInterval() : this.dateInterval,
      successfulness: successfulness ?? this.successfulness,
      rocketIds: rocketIds ?? this.rocketIds,
    );
  }

  /// Converts a given JSON [Map] into a [LaunchFiltering] instance.
  static LaunchFiltering fromJson(Map<String, dynamic> json) {
    return _$LaunchFilteringFromJson(json);
  }

  /// Converts this [LaunchFiltering] instance into a JSON [Map].
  Map<String, dynamic> toJson() => _$LaunchFilteringToJson(this);

  @override
  List<Object?> get props => [
        searchedPhrase,
        time,
        flightNumber,
        dateInterval,
        successfulness,
        rocketIds,
      ];
}
