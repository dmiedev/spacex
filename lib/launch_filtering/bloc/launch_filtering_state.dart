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
    required this.sorting,
    required this.filtering,
    this.allRockets,
    required this.status,
  });

  /// Creates a state of [LaunchFilteringBloc] that contains default selection
  /// and no loaded filtering parameters.
  const LaunchFilteringState.initial()
      : this(
          sorting: const LaunchSorting(
            parameter: LaunchSortingParameter.date,
            order: SortOrder.ascending,
          ),
          filtering: const LaunchFiltering(),
          status: LaunchFilteringSaveLoadStatus.none,
        );

  /// The sorting option to use while displaying matched launches.
  final LaunchSorting sorting;

  /// Filtering options to match specific launches.
  final LaunchFiltering filtering;

  /// Launch rocket options to select from.
  ///
  /// If this list is `null`, rockets have not been loaded yet.
  /// If it is empty, an error occurred while loading them.
  final List<RocketInfo>? allRockets;

  /// Whether rocket options are loaded.
  bool get allRocketsAreLoaded => allRockets != null && allRockets!.isNotEmpty;

  /// The last status of saving or loading filtering options.
  final LaunchFilteringSaveLoadStatus status;

  /// Creates a clone of this [LaunchFilteringState] but with provided
  /// parameters overridden.
  LaunchFilteringState copyWith({
    LaunchSorting? sorting,
    LaunchFiltering? filtering,
    List<RocketInfo>? Function()? allRockets,
    LaunchFilteringSaveLoadStatus? status,
  }) {
    return LaunchFilteringState(
      sorting: sorting ?? this.sorting,
      filtering: filtering ?? this.filtering,
      allRockets: allRockets != null ? allRockets() : this.allRockets,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        sorting,
        filtering,
        allRockets,
        status,
      ];
}
