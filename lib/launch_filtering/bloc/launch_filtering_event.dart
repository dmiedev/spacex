import 'package:equatable/equatable.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:spacex/launch_filtering/bloc/bloc.dart';

abstract class LaunchFilteringEvent extends Equatable {
  const LaunchFilteringEvent();

  @override
  List<Object?> get props => [];
}

class LaunchFilteringSearchedTextSubmitted extends LaunchFilteringEvent {
  const LaunchFilteringSearchedTextSubmitted({
    required this.searchedText,
  });

  final String searchedText;

  @override
  List<Object?> get props => [searchedText];
}

class LaunchFilteringSortingSelected extends LaunchFilteringEvent {
  const LaunchFilteringSortingSelected({
    required this.feature,
  });

  final LaunchFeature feature;

  @override
  List<Object?> get props => [feature];
}

class LaunchFilteringSortingOrderSwitched extends LaunchFilteringEvent {}

class LaunchFilteringTimeSwitched extends LaunchFilteringEvent {}

class LaunchFilteringFlightNumberSet extends LaunchFilteringEvent {
  const LaunchFilteringFlightNumberSet({
    required this.flightNumber,
  });

  final int flightNumber;

  @override
  List<Object?> get props => [flightNumber];
}

class LaunchFilteringDateIntervalSet extends LaunchFilteringEvent {
  const LaunchFilteringDateIntervalSet({
    this.dateInterval,
  });

  final DateTimeInterval? dateInterval;

  @override
  List<Object?> get props => [dateInterval];
}

class LaunchFilteringSuccessfulnessSelected extends LaunchFilteringEvent {
  const LaunchFilteringSuccessfulnessSelected({
    required this.successfulness,
  });

  final LaunchSuccessfulness successfulness;

  @override
  List<Object?> get props => [successfulness];
}
