import 'package:equatable/equatable.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:spacex_api/spacex_api.dart';

enum LaunchTime { past, upcoming }

enum LaunchSuccessfulness { any, success, failure }

class LaunchFilteringState extends Equatable {
  const LaunchFilteringState({
    required this.searchedText,
    required this.sorting,
    required this.time,
    this.dateInterval,
    required this.flightNumber,
    required this.successfulness,
  });

  const LaunchFilteringState.initial()
      : this(
          searchedText: '',
          sorting: const SortingOption(
            feature: LaunchFeature.date,
            order: SortOrder.ascending,
          ),
          time: LaunchTime.upcoming,
          dateInterval: null,
          flightNumber: -1,
          successfulness: LaunchSuccessfulness.any,
        );

  final String searchedText;
  final SortingOption sorting;
  final LaunchTime time;
  final DateTimeInterval? dateInterval;
  final int flightNumber;
  final LaunchSuccessfulness successfulness;

  LaunchFilteringState copyWith({
    String? searchedText,
    SortingOption? sorting,
    LaunchTime? time,
    DateTimeInterval? Function()? dateInterval,
    int? flightNumber,
    LaunchSuccessfulness? successfulness,
  }) {
    return LaunchFilteringState(
      searchedText: searchedText ?? this.searchedText,
      sorting: sorting ?? this.sorting,
      time: time ?? this.time,
      dateInterval: dateInterval != null ? dateInterval() : this.dateInterval,
      flightNumber: flightNumber ?? this.flightNumber,
      successfulness: successfulness ?? this.successfulness,
    );
  }

  @override
  List<Object?> get props => [
        searchedText,
        sorting,
        time,
        dateInterval,
        flightNumber,
        successfulness,
      ];
}
