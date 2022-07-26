import 'package:equatable/equatable.dart';
import 'package:spacex/rockets/bloc/bloc.dart';
import 'package:spacex_api/spacex_api.dart';

/// A state of [RocketBloc].
abstract class RocketState extends Equatable {
  /// The abstract constructor of a state of [RocketBloc].
  const RocketState();

  @override
  List<Object> get props => [];
}

/// A state of [RocketBloc] that is empty and considered initial.
class RocketInitial extends RocketState {}

/// A state of [RocketBloc] indicating that loading of rockets is in progress.
class RocketLoadInProgress extends RocketState {}

/// A state of [RocketBloc] indicating that rockets has been loaded
/// successfully.
class RocketLoadSuccess extends RocketState {
  /// Creates a state of [RocketBloc] indicating that rockets has been loaded
  /// successfully.
  const RocketLoadSuccess({required this.rockets});

  /// A list of loaded rockets.
  final List<Rocket> rockets;

  @override
  List<Object> get props => [];
}

/// A state of [RocketBloc] indicating that there was a failure to load rockets.
class RocketLoadFailure extends RocketState {}
