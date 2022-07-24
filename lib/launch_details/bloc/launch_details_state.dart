import 'package:equatable/equatable.dart';
import 'package:spacex_api/spacex_api.dart';

class LaunchDetailsState extends Equatable {
  const LaunchDetailsState({required this.launch});

  final Launch launch;

  @override
  List<Object> get props => [];
}
