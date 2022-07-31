import 'package:equatable/equatable.dart';
import 'package:filter_repository/filter_repository.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:meta/meta.dart';
import 'package:spacex/launches/bloc/bloc.dart';

/// An event to [LaunchBloc].
@immutable
abstract class LaunchEvent extends Equatable {
  /// An abstract constructor of an event to [LaunchBloc].
  const LaunchEvent();

  @override
  List<Object?> get props => [];
}

/// An event to [LaunchBloc] indicating there was a request for a page
/// containing launches that match specified filtering criteria.
class LaunchPageRequested extends LaunchEvent {
  /// Creates an event to [LaunchBloc] indicating there was a request for a page
  /// containing launches that match specified filtering criteria.
  const LaunchPageRequested({
    required this.pageNumber,
    this.searchedText,
    this.sorting,
    this.time,
    this.dateInterval,
    this.flightNumber,
    this.successfulness,
    this.rocketIds,
  });

  /// The number of the page that was requested.
  final int pageNumber;

  /// Text that matches launches whose data contains it.
  final String? searchedText;

  /// The sorting option to use while displaying matched launches.
  final SortingOption<LaunchFeature>? sorting;

  /// Time that launches should match.
  final LaunchTime? time;

  /// The date interval that launch date should match.
  final DateTimeInterval? dateInterval;

  /// The flight number launches should have.
  final int? flightNumber;

  /// The successfulness that launches should match.
  final LaunchSuccessfulness? successfulness;

  /// IDs of rockets whose launches are requested.
  final List<String>? rocketIds;

  @override
  List<Object?> get props => [
        pageNumber,
        searchedText,
        sorting,
        time,
        dateInterval,
        flightNumber,
        successfulness,
        rocketIds,
      ];
}
