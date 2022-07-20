import 'package:equatable/equatable.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:meta/meta.dart';
import 'package:spacex/launches/bloc/bloc.dart';

@immutable
abstract class LaunchEvent extends Equatable {
  const LaunchEvent();

  @override
  List<Object?> get props => [];
}

class LaunchPageRequested extends LaunchEvent {
  const LaunchPageRequested({
    required this.searchedText,
    this.firstPage = false,
  });

  final String searchedText;
  final bool firstPage;

  @override
  List<Object?> get props => [searchedText, firstPage];
}

class LaunchSortingSelected extends LaunchEvent {
  const LaunchSortingSelected({required this.feature});

  final LaunchFeature feature;

  @override
  List<Object?> get props => [feature];
}

class LaunchSortingOrderSwitched extends LaunchEvent {}

class LaunchTimeSwitched extends LaunchEvent {}

class LaunchFlightNumberSet extends LaunchEvent {
  const LaunchFlightNumberSet({
    required this.flightNumber,
  });

  final int flightNumber;

  @override
  List<Object?> get props => [flightNumber];
}

class LaunchSuccessfulnessSelected extends LaunchEvent {
  const LaunchSuccessfulnessSelected({
    required this.successfulness,
  });

  final LaunchSuccessfulness successfulness;

  @override
  List<Object?> get props => [successfulness];
}
