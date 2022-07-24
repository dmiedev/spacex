import 'package:equatable/equatable.dart';
import 'package:spacex/launch_details/bloc/bloc.dart';
import 'package:spacex_api/spacex_api.dart';

/// A state of [LaunchDetailsBloc].
class LaunchDetailsState extends Equatable {
  /// Creates a state of [LaunchDetailsBloc].
  const LaunchDetailsState({required this.launch});

  /// The launch whose details are displayed.
  final Launch launch;

  @override
  List<Object> get props => [];
}
