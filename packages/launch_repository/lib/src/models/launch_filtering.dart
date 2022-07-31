import 'package:equatable/equatable.dart';
import 'package:filtered_repository/filtered_repository.dart';
import 'package:spacex_api/spacex_api.dart';

enum LaunchSuccessfulness {
  any,
  success,
  failure,
}

enum LaunchTime {
  past,
  upcoming,
}

class LaunchFiltering extends Equatable implements Filtering {
  const LaunchFiltering({
    this.searchedPhrase = '',
    this.name,
    this.time = LaunchTime.upcoming,
    this.flightNumber,
    this.dateInterval,
    this.successfulness = LaunchSuccessfulness.any,
    this.rocketIds = const [],
  });

  final String searchedPhrase;
  final String? name;
  final LaunchTime? time;
  final int? flightNumber;
  final DateTimeInterval? dateInterval;
  final LaunchSuccessfulness successfulness;
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
      if (successfulness != LaunchSuccessfulness.any)
        Filter.equal('success', successfulness == LaunchSuccessfulness.success),
      if (rocketIds.isNotEmpty) Filter.in_('rocket', rocketIds),
    ];
  }

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
