import 'package:equatable/equatable.dart';
import 'package:spacex_api/spacex_api.dart';

abstract class RocketState extends Equatable {
  const RocketState();

  @override
  List<Object> get props => [];
}

class RocketInitial extends RocketState {}

class RocketLoadInProgress extends RocketState {}

class RocketLoadSuccess extends RocketState {
  const RocketLoadSuccess({required this.rockets});

  final List<Rocket> rockets;

  @override
  List<Object> get props => [];
}

class RocketLoadFailure extends RocketState {}
