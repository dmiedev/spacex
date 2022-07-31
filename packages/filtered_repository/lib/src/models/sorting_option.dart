import 'package:equatable/equatable.dart';
import 'package:spacex_api/spacex_api.dart';

abstract class SortingParameter {
  const SortingParameter();

  String toFieldName();
}

/// A sorting option to be used for fetching objects.
class Sorting<T extends SortingParameter> extends Equatable {
  /// Creates a sorting option to be used for fetching objects.
  const Sorting({
    required this.parameter,
    required this.order,
  });

  /// A sorting parameter.
  final T parameter;

  /// The order in which to sort.
  final SortOrder order;

  @override
  List<Object?> get props => [parameter, order];
}
