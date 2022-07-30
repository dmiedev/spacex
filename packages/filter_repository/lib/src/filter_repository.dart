import 'package:filter_repository/src/exceptions.dart';
import 'package:filter_repository/src/models/launch_filters.dart';
import 'package:hive/hive.dart';

/// A repository that manages the filter domain.
///
/// `Hive` must be initialized before using this repository.
class FilterRepository {
  /// Creates a repository that manages the filter domain.
  FilterRepository({Box<Object>? box}) : _box = box {
    _registerAdapters();
  }

  static const _filtersBoxName = 'filters';
  static const _launchFiltersKey = 'launch';

  Box<Object>? _box;

  void _registerAdapters() {
    _registerAdapter(LaunchTimeAdapter());
    _registerAdapter(LaunchSuccessfulnessAdapter());
    _registerAdapter(LaunchFiltersAdapter());
  }

  void _registerAdapter<T>(TypeAdapter<T> adapter) {
    if (!Hive.isAdapterRegistered(adapter.typeId)) {
      Hive.registerAdapter(adapter);
    }
  }

  /// Initializes this repository and loads all saved filters into memory.
  Future<void> initialize() async {
    _box = await Hive.openBox(_filtersBoxName);
  }

  void _checkIsInitialized() {
    if (_box == null) {
      throw FilterRepositoryNotInitializedException();
    }
  }

  /// Saves provided [filters] on disk.
  ///
  /// Throws a [FilterSaveLoadException] if saving fails.
  Future<void> saveLaunchFilters(LaunchFilters filters) {
    _checkIsInitialized();
    try {
      return _box!.put(_launchFiltersKey, filters);
    } on Exception {
      throw FilterSaveLoadException();
    }
  }

  /// Returns saved launch filters or `null` if no launch filters have been
  /// saved.
  ///
  /// Throws a [FilterSaveLoadException] if retrieving fails.
  LaunchFilters? getLaunchFilters() {
    _checkIsInitialized();
    try {
      return _box!.get(_launchFiltersKey) as LaunchFilters?;
    } on Exception {
      throw FilterSaveLoadException();
    }
  }
}
