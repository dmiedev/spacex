import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:spacex/launches/bloc/bloc.dart';
import 'package:spacex_api/spacex_api.dart';

/// Status of [LaunchState].
enum LaunchStateStatus {
  /// Status indicating that the last attempt to load data was successful.
  success,

  /// Status indicating that additional data is currently being loaded.
  loading,

  /// Status indicating that the last attempt to load data was unsuccessful.
  failure,
}

/// A state of [LaunchBloc] that contains data about currently loaded launches.
@immutable
class LaunchState extends Equatable {
  /// Creates a state of [LaunchBloc] that contains data about currently loaded
  /// launches.
  const LaunchState({
    required this.launches,
    required this.lastPageNumber,
    required this.hasReachedEnd,
    required this.status,
  });

  /// Creates a state of [LaunchBloc] that contains no loaded launch pages
  /// and a status set to [LaunchStateStatus.loading].
  const LaunchState.initial()
      : this(
          launches: const [],
          lastPageNumber: 0,
          hasReachedEnd: false,
          status: LaunchStateStatus.loading,
        );

  /// List of launches that has been loaded so far.
  final List<Launch> launches;

  /// The number of the last page with launches that has been loaded.
  final int lastPageNumber;

  /// Whether there are no more launch pages available.
  final bool hasReachedEnd;

  /// The current status of this state.
  final LaunchStateStatus status;

  /// Creates a clone of this [LaunchState] but with provided parameters
  /// overridden.
  LaunchState copyWith({
    List<Launch>? launches,
    int? lastPageNumber,
    bool? hasReachedEnd,
    LaunchStateStatus? status,
  }) {
    return LaunchState(
      launches: launches ?? this.launches,
      lastPageNumber: lastPageNumber ?? this.lastPageNumber,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'LaunchState(launches[${launches.length}], lastPageNumber: '
        '$lastPageNumber, hasReachedEnd: $hasReachedEnd, status: $status)';
  }

  @override
  List<Object?> get props => [
        launches,
        lastPageNumber,
        hasReachedEnd,
        status,
      ];
}
