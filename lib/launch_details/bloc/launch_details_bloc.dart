import 'package:bloc/bloc.dart';
import 'package:spacex/launch_details/bloc/bloc.dart';
import 'package:spacex_api/spacex_api.dart';

/// A [Bloc] that manages the launch details feature.
class LaunchDetailsBloc extends Bloc<LaunchDetailsEvent, LaunchDetailsState> {
  /// Creates a [Bloc] that manages the launch details feature.
  LaunchDetailsBloc({required Launch launch})
      : super(LaunchDetailsState(launch: launch));
}
