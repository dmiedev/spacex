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

/// An event to [LaunchFilteringBloc] indicating searched text was submitted.
class LaunchFilteringSearchedTextSubmitted extends LaunchFilteringEvent {
  /// Creates an event to [LaunchFilteringBloc] indicating searched text was
  /// submitted.
  const LaunchFilteringSearchedTextSubmitted({
    required this.searchedText,
  });

  /// Submitted searched text.
  final String searchedText;

  @override
  List<Object?> get props => [searchedText];
}

/// An event to [LaunchFilteringBloc] indicating launch sorting was selected.
class LaunchFilteringSortingSelected extends LaunchFilteringEvent {
  /// Creates an event to [LaunchFilteringBloc] indicating launch sorting was
  /// selected.
  const LaunchFilteringSortingSelected({
    required this.feature,
  });

  /// The launch feature that the sorting is related to.
  final LaunchFeature feature;

  @override
  List<Object?> get props => [feature];
}

/// An event to [LaunchFilteringBloc] indicating launch sorting order was
/// switched.
class LaunchFilteringSortingOrderSwitched extends LaunchFilteringEvent {}

/// An event to [LaunchFilteringBloc] indicating launch time was switched.
class LaunchFilteringTimeSwitched extends LaunchFilteringEvent {}

/// An event to [LaunchFilteringBloc] indicating launch flight number was set.
class LaunchFilteringFlightNumberSet extends LaunchFilteringEvent {
  /// Creates an event to [LaunchFilteringBloc] indicating launch flight number
  /// was set.
  const LaunchFilteringFlightNumberSet({
    required this.flightNumber,
  });

  /// The flight number that was set.
  final int flightNumber;

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
class LaunchFilteringRocketsRequested extends LaunchFilteringEvent {}

/// An event to [LaunchFilteringBloc] indicating that launch rockets were
/// selected.
class LaunchFilteringRocketsSelected extends LaunchFilteringEvent {
  /// Creates an event to [LaunchFilteringBloc] indicating that launch rockets
  /// were selected.
  const LaunchFilteringRocketsSelected({
    required this.rockets,
  });

  /// The indices of [LaunchFilteringState.allRockets] of rockets that were
  /// selected.
  final List<int> rockets;

  @override
  List<Object?> get props => [rockets];
}
