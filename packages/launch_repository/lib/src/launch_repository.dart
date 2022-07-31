import 'package:filtered_repository/filtered_repository.dart';
import 'package:launch_repository/src/exceptions.dart';
import 'package:launch_repository/src/models/models.dart';
import 'package:local_settings_api/local_settings_api.dart';
import 'package:spacex_api/spacex_api.dart';

/// A repository that manages the rocket launch domain.
class LaunchRepository
    implements
        FilteredRepository<Launch, LaunchSortingParameter, LaunchFiltering> {
  /// Creates a repository that manages the rocket launch domain.
  LaunchRepository({
    SpacexApiClient? spacexApiClient,
    required LocalSettingsApi localSettingsApi,
  })  : _spacexApiClient = spacexApiClient ?? SpacexApiClient(),
        _localSettingsApi = localSettingsApi;

  static const _filteringSettingName = 'launch_filtering';
  static const _sortingSettingName = 'launch_sorting';

  final SpacexApiClient _spacexApiClient;
  final LocalSettingsApi _localSettingsApi;

  /// Fetches SpaceX rocket launches that meet the specified parameters.
  ///
  /// Throws a [LaunchFetchingException] if fetching fails.
  @override
  Future<List<Launch>> fetchFiltered({
    required int amount,
    required int pageNumber,
    Sorting<LaunchSortingParameter>? sorting,
    LaunchFiltering? filtering,
  }) async {
    final filters = filtering?.toFilters();
    try {
      final page = await _spacexApiClient.queryLaunches(
        filter: filters != null && filters.isNotEmpty
            ? Filter.and(filters)
            : const Filter.empty(),
        options: PaginationOptions(
          limit: amount,
          page: pageNumber,
          sort: sorting != null
              ? {sorting.parameter.toFieldName(): sorting.order}
              : null,
        ),
      );
      return page.docs;
    } on Exception {
      throw LaunchFetchingException();
    }
  }

  @override
  Sorting<LaunchSortingParameter>? loadSorting() {
    try {
      return _localSettingsApi.loadSetting(_sortingSettingName);
    } on Exception {
      throw LaunchSortingException();
    }
  }

  @override
  Future<void> saveSorting(Sorting<LaunchSortingParameter> sorting) {
    try {
      return _localSettingsApi.saveSetting(_sortingSettingName, sorting);
    } on Exception {
      throw LaunchSortingException();
    }
  }

  @override
  LaunchFiltering? loadFiltering() {
    try {
      return _localSettingsApi.loadSetting(_filteringSettingName);
    } on Exception {
      throw LaunchFilteringException();
    }
  }

  @override
  Future<void> saveFiltering(LaunchFiltering filtering) {
    try {
      return _localSettingsApi.saveSetting(_filteringSettingName, filtering);
    } on Exception {
      throw LaunchFilteringException();
    }
  }
}
