import 'package:filtered_repository/src/models/models.dart';

/// An interface for a SpaceX repository using filters.
abstract class FilteredRepository<T, S extends SortingParameter,
    R extends Filtering> {
  /// An abstract constructor of a [FilteredRepository].
  const FilteredRepository();

  /// Fetches specific SpaceX objects that meet the specified parameters.
  Future<List<T>> fetchFiltered({
    required int amount,
    required int pageNumber,
    Sorting<S>? sorting,
    R? filtering,
  });
}
