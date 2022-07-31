import 'package:equatable/equatable.dart';
import 'package:spacex/rockets/bloc/bloc.dart';

/// An event to [RocketBloc].
abstract class RocketEvent extends Equatable {
  /// The abstract constructor of an event to [RocketBloc].
  const RocketEvent();

  @override
  List<Object> get props => [];
}

/// An event to [RocketBloc] indicating that loading of rockets was requested.
class RocketLoadRequested extends RocketEvent {
  /// Creates an event to [RocketBloc] indicating that loading of rockets was
  /// requested.
  const RocketLoadRequested();
}
