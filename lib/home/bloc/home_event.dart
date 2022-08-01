import 'package:equatable/equatable.dart';
import 'package:spacex/home/bloc/bloc.dart';

/// An event to [HomeBloc].
abstract class HomeEvent extends Equatable {
  /// The abstract constructor of an event to [HomeBloc].
  const HomeEvent();

  @override
  List<Object> get props => [];
}

/// An event to [HomeBloc] indicating that page changed.
class HomePageChanged extends HomeEvent {
  /// Creates an event to [HomeBloc] indicating that page changed.
  const HomePageChanged({required this.newPage});

  /// The page that the user went to.
  final HomeStatePage newPage;

  @override
  List<Object> get props => [newPage];
}
