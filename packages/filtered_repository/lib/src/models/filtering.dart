import 'package:spacex_api/spacex_api.dart';

/// A collections of parameters used to filter queried objects.
abstract class Filtering {
  /// An abstract constructor of a [Filtering] instance.
  const Filtering();

  /// Converts this collection of filtering options to basic [Filter]s.
  List<Filter> toFilters();
}
