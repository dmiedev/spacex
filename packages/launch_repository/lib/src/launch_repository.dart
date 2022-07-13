import 'package:spacex_api/spacex_api.dart';

/// A repository that manages the rocket launch domain.
class LaunchRepository {
  /// Creates a repository that manages the rocket launch domain.
  LaunchRepository({
    SpacexApiClient? spacexApiClient,
  }) : _spacexApiClient = spacexApiClient ?? SpacexApiClient();

  final SpacexApiClient _spacexApiClient;

  /// Fetches SpaceX rocket launches that meet the specified parameters.
  List<Launch> fetchLaunches({
    required int amount,
    List<FilteringOption>? filters,
    SortingOption? sorting,
    String? searchedText,
    required int listNumber,
  }) {
    return [];
  }
}

class FilteringOption {}

class SortingOption {}

enum LaunchFeature {
  flightNumber,
}
