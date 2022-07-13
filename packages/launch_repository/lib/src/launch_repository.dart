import 'package:launch_repository/src/exceptions.dart';
import 'package:launch_repository/src/models/models.dart';
import 'package:spacex_api/spacex_api.dart';

/// A repository that manages the rocket launch domain.
class LaunchRepository {
  /// Creates a repository that manages the rocket launch domain.
  LaunchRepository({
    SpacexApiClient? spacexApiClient,
  }) : _spacexApiClient = spacexApiClient ?? SpacexApiClient();

  final SpacexApiClient _spacexApiClient;

  /// Fetches SpaceX rocket launches that meet the specified parameters.
  ///
  /// Throws a [RocketsFetchException] if fetching fails.
  Future<List<Launch>> fetchLaunches({
    required int amount,
    required int listNumber,
    List<FilteringOption> filtering = const [],
    SortingOption? sorting,
    String? searchedText,
  }) async {
    final filters = filtering.map((option) => option.toFilter()).toList();
    if (searchedText != null) {
      filters.add(Filter.text(TextFilterParameters(search: searchedText)));
    }
    try {
      final page = await _spacexApiClient.queryLaunches(
        filter: filters.isNotEmpty ? Filter.and(filters) : const Filter.empty(),
        options: PaginationOptions(
          limit: amount,
          page: listNumber,
          sort: sorting != null
              ? {sorting.feature.toFieldName(): sorting.order}
              : null,
        ),
      );
      return page.docs;
    } on Exception {
      throw RocketsFetchException();
    }
  }
}
