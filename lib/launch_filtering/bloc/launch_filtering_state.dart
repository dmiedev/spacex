import 'package:equatable/equatable.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:rocket_repository/rocket_repository.dart';
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
    this.allRockets,
    required this.rockets,
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
          rockets: const [],
        );

  final String searchedText;
  final SortingOption sorting;
  final LaunchTime time;
  final DateTimeInterval? dateInterval;
  final int flightNumber;
  final LaunchSuccessfulness successfulness;
  final List<RocketInfo>? allRockets;
  final List<int> rockets;

  bool get allRocketsAreLoaded => allRockets != null && allRockets!.isNotEmpty;

  LaunchFilteringState copyWith({
    String? searchedText,
    SortingOption? sorting,
    LaunchTime? time,
    DateTimeInterval? Function()? dateInterval,
    int? flightNumber,
    LaunchSuccessfulness? successfulness,
    List<RocketInfo>? Function()? allRockets,
    List<int>? rockets,
  }) {
    return LaunchFilteringState(
      searchedText: searchedText ?? this.searchedText,
      sorting: sorting ?? this.sorting,
      time: time ?? this.time,
      dateInterval: dateInterval != null ? dateInterval() : this.dateInterval,
      flightNumber: flightNumber ?? this.flightNumber,
      successfulness: successfulness ?? this.successfulness,
      allRockets: allRockets != null ? allRockets() : this.allRockets,
      rockets: rockets ?? this.rockets,
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
        allRockets,
        rockets,
      ];
}
