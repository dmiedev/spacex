import 'package:equatable/equatable.dart';
import 'package:spacex_api/spacex_api.dart';

/// A parameter of a sorting option.
abstract class SortingParameter {
  /// An abstract constructor of a [SortingParameter] instance.
  const SortingParameter();

  /// Converts this parameter to an object's field name in `snake_case`.
  String toFieldName();
}

/// A sorting option to be used for fetching objects.
abstract class Sorting<T extends SortingParameter> extends Equatable {
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
