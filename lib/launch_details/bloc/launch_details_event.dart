import 'package:equatable/equatable.dart';
import 'package:spacex/launch_details/bloc/bloc.dart';

/// An event to [LaunchDetailsBloc].
abstract class LaunchDetailsEvent extends Equatable {
  /// An abstract constructor of an event to [LaunchDetailsBloc].
  const LaunchDetailsEvent();

  @override
  List<Object> get props => [];
}
