import 'package:json_annotation/json_annotation.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:meta/meta.dart';
import 'package:spacex_api/spacex_api.dart';

enum LaunchTime { past, upcoming }

enum LaunchSuccessfulness { any, success, failure }

@immutable
@JsonSerializable()
class LaunchState {
  const LaunchState({
    required this.launches,
    required this.lastPageNumber,
    required this.hasReachedEnd,
    required this.errorOccurred,
    required this.searchedText,
    required this.sorting,
    required this.time,
    required this.successfulness,
  });

  const LaunchState.initial()
      : this(
          launches: null,
          lastPageNumber: 0,
          hasReachedEnd: false,
          errorOccurred: false,
          searchedText: '',
          sorting: const SortingOption(
            feature: LaunchFeature.date,
            order: SortOrder.ascending,
          ),
          time: LaunchTime.upcoming,
          successfulness: LaunchSuccessfulness.any,
        );

  final List<Launch>? launches;
  final int lastPageNumber;
  final bool hasReachedEnd;
  final bool errorOccurred;
  final String searchedText;
  final SortingOption sorting;
  final LaunchTime time;
  final LaunchSuccessfulness successfulness;

  LaunchState getEmpty({
    SortingOption? sorting,
    LaunchTime? time,
    LaunchSuccessfulness? successfulness,
  }) {
    return const LaunchState.initial().copyWith(
      searchedText: searchedText,
      sorting: sorting ?? this.sorting,
      time: time ?? this.time,
      successfulness: successfulness ?? this.successfulness,
    );
  }

  LaunchState copyWith({
    List<Launch>? launches,
    int? lastPageNumber,
    bool? hasReachedEnd,
    bool? errorOccurred,
    String? searchedText,
    SortingOption? sorting,
    LaunchTime? time,
    LaunchSuccessfulness? successfulness,
  }) {
    return LaunchState(
      launches: launches ?? this.launches,
      lastPageNumber: lastPageNumber ?? this.lastPageNumber,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      errorOccurred: errorOccurred ?? this.errorOccurred,
      searchedText: searchedText ?? this.searchedText,
      sorting: sorting ?? this.sorting,
      time: time ?? this.time,
      successfulness: successfulness ?? this.successfulness,
    );
  }

  // TODO(dmiedev): change toString()
  @override
  String toString() {
    return 'LaunchState(launches[${launches?.length}], $lastPageNumber, '
        '$hasReachedEnd, $errorOccurred, $sorting)';
  }
}
