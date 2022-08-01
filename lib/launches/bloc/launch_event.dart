import 'package:equatable/equatable.dart';
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
    this.sorting,
    this.filtering,
  });

  /// The number of the page that was requested.
  final int pageNumber;

  /// The sorting option to use while displaying matched launches.
  final LaunchSorting? sorting;

  /// Filtering options to use to match specific launches.
  final LaunchFiltering? filtering;

  @override
  List<Object?> get props => [pageNumber, sorting, filtering];
}
