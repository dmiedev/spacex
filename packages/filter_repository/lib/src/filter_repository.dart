import 'package:filter_repository/src/exceptions.dart';
import 'package:filter_repository/src/models/launch_filters.dart';
import 'package:hive/hive.dart';

/// A repository that manages the filter domain.
///
/// `Hive` must be initialized before using this repository.
class FilterRepository {
  /// Creates a repository that manages the filter domain.
  FilterRepository();

  static const _filtersBoxName = 'filters';
  static const _launchFiltersKey = 'launch';

  late final Box<Object> _box;

  /// Initializes this repository and loads all saved filters into memory.
  Future<void> initialize([String? subDir]) async {
    Hive.registerAdapter(LaunchFiltersAdapter());
    _box = await Hive.openBox(_filtersBoxName);
  }

  /// Saves provided [filters] on disk.
  ///
  /// Throws a [FilterSaveLoadException] if saving fails.
  Future<void> saveLaunchFilters(LaunchFilters filters) {
    try {
      return _box.put(_launchFiltersKey, filters);
    } on Exception {
      throw FilterSaveLoadException();
    }
  }

  /// Returns saved launch filters or `null` if no launch filters have been
  /// saved.
  ///
  /// Throws a [FilterSaveLoadException] if retrieving fails.
  LaunchFilters? getLaunchFilters() {
    try {
      return _box.get(_launchFiltersKey) as LaunchFilters?;
    } on Exception {
      throw FilterSaveLoadException();
    }
  }
}
