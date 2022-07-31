import 'package:equatable/equatable.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:spacex/launch_filtering/bloc/bloc.dart';

/// An event to [LaunchFilteringBloc].
abstract class LaunchFilteringEvent extends Equatable {
  /// An abstract constructor of an event to [LaunchFilteringBloc].
  const LaunchFilteringEvent();

  @override
  List<Object?> get props => [];
}

/// An event to [LaunchFilteringBloc] indicating filtering options were loaded.
class LaunchFilteringLoaded extends LaunchFilteringEvent {
  /// Creates an event to [LaunchFilteringBloc] indicating filtering options
  /// were loaded.
  const LaunchFilteringLoaded();
}

/// An event to [LaunchFilteringBloc] indicating filtering options were saved.
class LaunchFilteringSaved extends LaunchFilteringEvent {
  /// Creates an event to [LaunchFilteringBloc] indicating filtering options
  /// were saved.
  const LaunchFilteringSaved();
}

/// An event to [LaunchFilteringBloc] indicating searched phrase was submitted.
class LaunchFilteringSearchedTextSubmitted extends LaunchFilteringEvent {
  /// Creates an event to [LaunchFilteringBloc] indicating searched phrase was
  /// submitted.
  const LaunchFilteringSearchedTextSubmitted({
    required this.searchedPhrase,
  });

  /// Submitted searched phrase.
  final String searchedPhrase;

  @override
  List<Object?> get props => [searchedPhrase];
}

/// An event to [LaunchFilteringBloc] indicating launch sorting was selected.
class LaunchFilteringSortingSelected extends LaunchFilteringEvent {
  /// Creates an event to [LaunchFilteringBloc] indicating launch sorting was
  /// selected.
  const LaunchFilteringSortingSelected({
    required this.sortingParameter,
  });

  /// The launch parameter that the sorting is related to.
  final LaunchSortingParameter sortingParameter;

  @override
  List<Object?> get props => [sortingParameter];
}

/// An event to [LaunchFilteringBloc] indicating launch sorting order was
/// switched.
class LaunchFilteringSortingOrderSwitched extends LaunchFilteringEvent {
  /// Creates an event to [LaunchFilteringBloc] indicating launch sorting order
  /// was switched.
  const LaunchFilteringSortingOrderSwitched();
}

/// An event to [LaunchFilteringBloc] indicating launch time was switched.
class LaunchFilteringTimeSwitched extends LaunchFilteringEvent {
  /// Creates an event to [LaunchFilteringBloc] indicating launch time was
  /// switched.
  const LaunchFilteringTimeSwitched();
}

/// An event to [LaunchFilteringBloc] indicating launch flight number was set.
class LaunchFilteringFlightNumberSet extends LaunchFilteringEvent {
  /// Creates an event to [LaunchFilteringBloc] indicating launch flight number
  /// was set.
  const LaunchFilteringFlightNumberSet({
    required this.flightNumber,
  });

  /// The flight number that was set.
  final int? flightNumber;

  @override
  List<Object?> get props => [flightNumber];
}

/// An event to [LaunchFilteringBloc] indicating launch date interval was set.
class LaunchFilteringDateIntervalSet extends LaunchFilteringEvent {
  /// Creates an event to [LaunchFilteringBloc] indicating launch date interval
  /// was set.
  const LaunchFilteringDateIntervalSet({
    this.dateInterval,
  });

  /// The date interval that was set.
  final DateTimeInterval? dateInterval;

  @override
  List<Object?> get props => [dateInterval];
}

/// An event to [LaunchFilteringBloc] indicating launch successfulness was
/// selected.
class LaunchFilteringSuccessfulnessSelected extends LaunchFilteringEvent {
  /// Creates an event to [LaunchFilteringBloc] indicating launch successfulness
  /// was selected.
  const LaunchFilteringSuccessfulnessSelected({
    required this.successfulness,
  });

  /// The launch successfulness that was selected.
  final LaunchSuccessfulness successfulness;

  @override
  List<Object?> get props => [successfulness];
}

/// An event to [LaunchFilteringBloc] indicating that a list of rockets was
/// requested.
class LaunchFilteringRocketsRequested extends LaunchFilteringEvent {
  /// Creates an event to [LaunchFilteringBloc] indicating that a list of
  /// rockets was requested.
  const LaunchFilteringRocketsRequested();
}

/// An event to [LaunchFilteringBloc] indicating that launch rockets were
/// selected.
class LaunchFilteringRocketsSelected extends LaunchFilteringEvent {
  /// Creates an event to [LaunchFilteringBloc] indicating that launch rockets
  /// were selected.
  const LaunchFilteringRocketsSelected({
    required this.rocketSelection,
  });

  /// A list that indicates whether a particular rocket from
  /// [LaunchFilteringState.allRockets] was selected.
  final List<bool> rocketSelection;

  @override
  List<Object?> get props => [rocketSelection];
}
