import 'package:spacex_api/spacex_api.dart';

/// A collections of parameters used to filter queried objects.
abstract class Filtering {
  const Filtering();

  List<Filter> toFilters();
}
