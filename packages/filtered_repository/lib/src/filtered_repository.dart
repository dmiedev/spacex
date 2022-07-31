import 'package:filtered_repository/src/models/models.dart';

/// An interface for a SpaceX repository using filters.
abstract class FilteredRepository<T, S extends Feature> {
  /// An abstract constructor of [FilteredRepository].
  const FilteredRepository();

  /// Fetches specific SpaceX objects that meet the specified [parameters].
  Future<List<T>> fetchFiltered({
    required int amount,
    required int pageNumber,
    FilterParameters<S> parameters,
  });
}
