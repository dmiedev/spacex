import 'package:json_annotation/json_annotation.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:meta/meta.dart';
import 'package:spacex_api/spacex_api.dart';

enum LaunchTimeFiltering { past, upcoming }

@immutable
@JsonSerializable()
class LaunchState {
  const LaunchState({
    required this.launches,
    required this.lastPageNumber,
    required this.hasReachedEnd,
    required this.errorOccurred,
    required this.searchedText,
    required this.sortingOption,
    required this.timeFiltering,
  });

  const LaunchState.initial()
      : this(
          launches: null,
          lastPageNumber: 0,
          hasReachedEnd: false,
          errorOccurred: false,
          searchedText: '',
          sortingOption: const SortingOption(
            feature: LaunchFeature.date,
            order: SortOrder.ascending,
          ),
          timeFiltering: LaunchTimeFiltering.upcoming,
        );

  final List<Launch>? launches;
  final int lastPageNumber;
  final bool hasReachedEnd;
  final bool errorOccurred;
  final String searchedText;
  final SortingOption sortingOption;
  final LaunchTimeFiltering timeFiltering;

  LaunchState copyWith({
    List<Launch>? launches,
    int? lastPageNumber,
    bool? hasReachedEnd,
    bool? errorOccurred,
    String? searchedText,
    SortingOption? sortingOption,
    LaunchTimeFiltering? timeFiltering,
  }) {
    return LaunchState(
      launches: launches ?? this.launches,
      lastPageNumber: lastPageNumber ?? this.lastPageNumber,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      errorOccurred: errorOccurred ?? this.errorOccurred,
      searchedText: searchedText ?? this.searchedText,
      sortingOption: sortingOption ?? this.sortingOption,
      timeFiltering: timeFiltering ?? this.timeFiltering,
    );
  }

  // TODO(dmiedev): change toString()
  @override
  String toString() {
    return 'LaunchState(launches[${launches?.length}], $lastPageNumber, '
        '$hasReachedEnd, $errorOccurred, $sortingOption)';
  }
}
