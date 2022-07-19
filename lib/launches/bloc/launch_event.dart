import 'package:equatable/equatable.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LaunchEvent extends Equatable {
  const LaunchEvent();

  @override
  List<Object?> get props => [];
}

class LaunchPageRequested extends LaunchEvent {
  const LaunchPageRequested({
    required this.searchedText,
    this.firstPage = false,
  });

  final String searchedText;
  final bool firstPage;

  @override
  List<Object?> get props => [searchedText, firstPage];
}

class LaunchSortingOptionAdded extends LaunchEvent {
  const LaunchSortingOptionAdded({required this.feature});

  final LaunchFeature feature;

  @override
  List<Object?> get props => [feature];
}

class LaunchSortingOrderSwitched extends LaunchEvent {}

class LaunchTimeFilteringSwitched extends LaunchEvent {}

class LaunchFilteringOptionRemoved extends LaunchEvent {
  const LaunchFilteringOptionRemoved({required this.feature});

  final LaunchFeature feature;

  @override
  List<Object?> get props => [feature];
}
