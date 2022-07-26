import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// A repository that manages the filter domain.
class FilterRepository {
  /// Creates a repository that manages the filter domain.
  FilterRepository();

  static const _filtersBoxName = 'filters';
  static const _launchFiltersName = 'launch';

  late final LazyBox _box;

  // where to put this?
  Future<void> initialize() async {
    _box = await Hive.openLazyBox(_filtersBoxName);
  }
}
