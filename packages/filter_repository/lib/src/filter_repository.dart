import 'package:filter_repository/src/exceptions.dart';
import 'package:filter_repository/src/models/launch_filters.dart';
import 'package:hive/hive.dart';

/// A repository that manages the filter domain.
class FilterRepository {
  /// Creates a repository that manages the filter domain.
  FilterRepository();

  static const _filtersBoxName = 'filters';
  static const _launchFiltersKey = 'launch';

  late final LazyBox _box;

  Future<void> initialize() async {
    Hive.registerAdapter(LaunchFiltersAdapter());

    _box = await Hive.openLazyBox(_filtersBoxName);
  }

  Future<void> saveLaunchFilters(LaunchFilters filters) {
    try {
      return _box.put(_launchFiltersKey, filters);
    } on Exception {
      throw FilterSaveLoadException();
    }
  }

  Future<LaunchFilters?> retrieveLaunchFilters() async {
    try {
      final filters = await _box.get(_launchFiltersKey);
      return filters as LaunchFilters?;
    } on Exception {
      throw FilterSaveLoadException();
    }
  }
}
