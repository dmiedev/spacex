import 'package:equatable/equatable.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:rocket_repository/rocket_repository.dart';
import 'package:spacex/launch_filtering/bloc/launch_filtering_bloc.dart';
import 'package:spacex_api/spacex_api.dart';

/// Status of saving or loading filtering options.
enum LaunchFilteringSaveLoadStatus {
  /// A status indicating nothing has been done so far.
  none,

  /// A status indicating that nothing was loaded because options had not been
  /// saved yet.
  loadedNothing,

  /// A status indicating that there was a failure to load filtering options
  saveFailure,

  /// A status indicating filters have been saved successfully.
  saveSuccess,

  /// A status indicating filters have not been loaded due to a failure.
  loadFailure,

  /// A status indicating filters have been loaded successfully.
  loadSuccess,
}

/// A state of [LaunchFilteringBloc] that contains data about currently selected
/// launch filtering and sorting.
class LaunchFilteringState extends Equatable {
  /// Creates a state of [LaunchFilteringBloc] that contains data about
  /// currently selected launch filtering and sorting.
  const LaunchFilteringState({
    required this.searchedText,
    required this.sorting,
    required this.time,
    this.dateInterval,
    required this.flightNumber,
    required this.successfulness,
    this.allRockets,
    required this.rocketIds,
    required this.status,
  });

  /// Creates a state of [LaunchFilteringBloc] that contains default selection
  /// and no loaded filtering parameters.
  const LaunchFilteringState.initial()
      : this(
          searchedText: '',
          sorting: const Sorting<LaunchSortingParameter>(
            parameter: LaunchSortingParameter.date,
            order: SortOrder.ascending,
          ),
          time: LaunchTime.upcoming,
          dateInterval: null,
          flightNumber: null,
          successfulness: LaunchSuccessfulness.any,
          allRockets: null,
          rocketIds: const [],
          status: LaunchFilteringSaveLoadStatus.none,
        );

  /// Text that matches launches whose data contains it.
  final String searchedText;

  /// The sorting option to use while displaying matched launches.
  final Sorting<LaunchSortingParameter> sorting;

  /// Time that launches should match.
  final LaunchTime time;

  /// The date interval that launch date should match.
  final DateTimeInterval? dateInterval;

  /// The flight number launches should have.
  final int? flightNumber;

  /// The successfulness that launches should match.
  final LaunchSuccessfulness successfulness;

  /// Launch rocket options to select from.
  ///
  /// If this list is `null`, rockets have not been loaded yet.
  /// If it is empty, an error occurred while loading them.
  final List<RocketInfo>? allRockets;

  /// Whether rocket options are loaded.
  bool get allRocketsAreLoaded => allRockets != null && allRockets!.isNotEmpty;

  /// IDs of rockets whose launches should be displayed.
  final List<String> rocketIds;

  /// The last status of saving or loading filtering options.
  final LaunchFilteringSaveLoadStatus status;

  /// Creates a clone of this [LaunchFilteringState] but with provided
  /// parameters overridden.
  LaunchFilteringState copyWith({
    String? searchedText,
    Sorting<LaunchSortingParameter>? sorting,
    LaunchTime? time,
    DateTimeInterval? Function()? dateInterval,
    int? Function()? flightNumber,
    LaunchSuccessfulness? successfulness,
    List<RocketInfo>? Function()? allRockets,
    List<String>? rocketIds,
    LaunchFilteringSaveLoadStatus? status,
  }) {
    return LaunchFilteringState(
      searchedText: searchedText ?? this.searchedText,
      sorting: sorting ?? this.sorting,
      time: time ?? this.time,
      dateInterval: dateInterval != null ? dateInterval() : this.dateInterval,
      flightNumber: flightNumber != null ? flightNumber() : this.flightNumber,
      successfulness: successfulness ?? this.successfulness,
      allRockets: allRockets != null ? allRockets() : this.allRockets,
      rocketIds: rocketIds ?? this.rocketIds,
      status: status ?? this.status,
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
        rocketIds,
        status,
      ];
}
