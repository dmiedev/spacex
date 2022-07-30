import 'package:filtered_repository/filtered_repository.dart';
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
  /// Throws a [LaunchFetchingException] if fetching fails.
  Future<List<Launch>> fetchLaunches({
    required int amount,
    required int pageNumber,
    FilterParameters<LaunchFeature> parameters = const FilterParameters(),
  }) async {
    final filters =
        parameters.filtering.map((option) => option.toFilter()).toList();
    if (parameters.searchedPhrase != null) {
      filters.add(
        Filter.text(
          TextFilterParameters(search: '"${parameters.searchedPhrase}"'),
        ),
      );
    }
    try {
      final sorting = parameters.sorting;
      final page = await _spacexApiClient.queryLaunches(
        filter: filters.isNotEmpty ? Filter.and(filters) : const Filter.empty(),
        options: PaginationOptions(
          limit: amount,
          page: pageNumber,
          sort: sorting != null
              ? {sorting.feature.toFieldName(): sorting.order}
              : null,
        ),
      );
      return page.docs;
    } on Exception {
      throw LaunchFetchingException();
    }
  }
}
