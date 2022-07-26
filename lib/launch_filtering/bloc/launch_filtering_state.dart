import 'package:equatable/equatable.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:rocket_repository/rocket_repository.dart';
import 'package:spacex/launch_filtering/bloc/launch_filtering_bloc.dart';
import 'package:spacex_api/spacex_api.dart';

/// The time of a launch.
enum LaunchTime {
  /// Represents launches that happened in the past.
  past,

  /// Represents launches that are going to happen in the future.
  upcoming
}

/// Launch successfulness.
enum LaunchSuccessfulness {
  /// Represents launches with any successfulness.
  any,

  /// Represents successful launches.
  success,

  /// Represents failed launches.
  failure
}

/// A state of [LaunchFilteringBloc] that contains data about currently selected
/// launch filtering and sorting options.
class LaunchFilteringState extends Equatable {
  /// Creates a state of [LaunchFilteringBloc] that contains data about
  /// currently selected launch filtering and sorting options.
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

  /// Creates a state of [LaunchFilteringBloc] that contains default options
  /// and no loaded filtering parameters.
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
          allRockets: null,
          rockets: const [],
        );

  /// Text that matches launches whose data contains it.
  final String searchedText;

  /// The sorting option to use while displaying matched launches.
  final SortingOption sorting;

  /// Time that launches should match.
  final LaunchTime time;

  /// The date interval that launch date should match.
  final DateTimeInterval? dateInterval;

  /// The flight number launches should have.
  final int flightNumber;

  /// The successfulness that launches should match.
  final LaunchSuccessfulness successfulness;

  /// Launch rocket options to select from.
  final List<RocketInfo>? allRockets;

  /// The indices of [allRockets] whose launches should be displayed.
  final List<int> rockets;

  /// Whether rocket options are loaded.
  bool get allRocketsAreLoaded => allRockets != null && allRockets!.isNotEmpty;

  /// IDs of selected launch rockets.
  List<String>? get rocketIds {
    return allRockets != null
        ? rockets.map((index) => allRockets![index].id).toList()
        : null;
  }

  /// Creates a clone of this [LaunchFilteringState] but with provided
  /// parameters overridden.
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
