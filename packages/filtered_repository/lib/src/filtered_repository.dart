import 'dart:async';

import 'package:filtered_repository/src/models/models.dart';

/// An interface for a SpaceX repository using filters.
abstract class FilteredRepository<T, S extends Sorting, R extends Filtering> {
  /// Fetches specific SpaceX objects that meet the specified parameters.
  Future<List<T>> fetchFiltered({
    required int amount,
    required int pageNumber,
    S? sorting,
    R? filtering,
  });

  /// Saves a sorting used by this repository for a later use.
  FutureOr<void> saveSorting(S sorting);

  /// Loads the sorting used by this repository that was saved previously.
  FutureOr<S?> loadSorting();

  /// Saves a filtering used by this repository for a later use.
  FutureOr<void> saveFiltering(R filtering);

  /// Loads the filtering used by this repository that was saved previously.
  FutureOr<R?> loadFiltering();
}
