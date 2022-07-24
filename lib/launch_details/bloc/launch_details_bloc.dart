import 'package:bloc/bloc.dart';
import 'package:spacex/launch_details/bloc/bloc.dart';
import 'package:spacex_api/spacex_api.dart';

class LaunchDetailsBloc extends Bloc<LaunchDetailsEvent, LaunchDetailsState> {
  LaunchDetailsBloc({required Launch launch})
      : super(LaunchDetailsState(launch: launch));
}
