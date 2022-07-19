import 'package:json_annotation/json_annotation.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:meta/meta.dart';
import 'package:spacex_api/spacex_api.dart';

@immutable
@JsonSerializable()
class LaunchState {
  const LaunchState({
    required this.launches,
    required this.lastPageNumber,
    required this.lastPageAmount,
    required this.hasReachedEnd,
    required this.errorOccurred,
    required this.searchedText,
    required this.sortingOption,
  });

  const LaunchState.initial()
      : this(
          launches: const [],
          lastPageNumber: 0,
          lastPageAmount: 0,
          hasReachedEnd: false,
          errorOccurred: false,
          searchedText: '',
          sortingOption: const SortingOption(
            feature: LaunchFeature.date,
            order: SortOrder.ascending,
          ),
        );

  final List<Launch> launches;
  final int lastPageNumber;
  final int lastPageAmount;
  final bool hasReachedEnd;
  final bool errorOccurred;
  final String searchedText;
  final SortingOption sortingOption;

  @override
  String toString() {
    return 'LaunchState(launches[${launches.length}], $lastPageNumber, '
        '$lastPageAmount, $hasReachedEnd, $errorOccurred, $sortingOption)';
  }
}
