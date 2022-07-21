import 'package:equatable/equatable.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:meta/meta.dart';
import 'package:spacex/launch_filtering/bloc/bloc.dart';

@immutable
abstract class LaunchEvent extends Equatable {
  const LaunchEvent();

  @override
  List<Object?> get props => [];
}

class LaunchPageRequested extends LaunchEvent {
  const LaunchPageRequested({
    required this.pageNumber,
    this.searchedText,
    this.sorting,
    this.time,
    this.dateInterval,
    this.flightNumber,
    this.successfulness,
    this.rocketIds,
  });

  final int pageNumber;
  final String? searchedText;
  final SortingOption? sorting;
  final LaunchTime? time;
  final DateTimeInterval? dateInterval;
  final int? flightNumber;
  final LaunchSuccessfulness? successfulness;
  final List<String>? rocketIds;

  @override
  List<Object?> get props => [
        pageNumber,
        searchedText,
        sorting,
        time,
        dateInterval,
        flightNumber,
        successfulness,
        rocketIds,
      ];
}
