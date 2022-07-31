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
    this.searchedPhrase,
    this.name,
    this.time,
    this.flightNumber,
    this.dateInterval,
    this.successfulness,
    this.rocketIds,
  });

  final String? searchedPhrase;
  final String? name;
  final LaunchTime? time;
  final int? flightNumber;
  final DateTimeInterval? dateInterval;
  final LaunchSuccessfulness? successfulness;
  final List<String>? rocketIds;

  @override
  List<Filter> toFilters() {
    return [
      if (searchedPhrase != null && searchedPhrase!.isNotEmpty)
        Filter.text(TextFilterParameters(search: '"$searchedPhrase"')),
      if (name != null) Filter.equal('name', name!),
      if (time != null) Filter.equal('upcoming', time == LaunchTime.upcoming),
      if (flightNumber != null) Filter.equal('flight_number', flightNumber!),
      if (dateInterval != null)
        Filter.and([
          Filter.greaterThanOrEqual('date_utc', dateInterval!.from),
          Filter.lessThanOrEqual('date_utc', dateInterval!.to),
        ]),
      if (successfulness != null)
        Filter.equal('success', successfulness == LaunchSuccessfulness.success),
      if (rocketIds != null) Filter.in_('rocket', rocketIds!),
    ];
  }

  @override
  List<Object?> get props => [
        searchedPhrase,
        name,
        time,
        flightNumber,
        dateInterval,
        successfulness,
        rocketIds,
      ];
}
