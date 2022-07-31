import 'package:equatable/equatable.dart';
import 'package:filtered_repository/src/models/feature.dart';
import 'package:spacex_api/spacex_api.dart';

/// A sorting option to be used for fetching objects.
class SortingOption<T extends Feature> extends Equatable {
  /// Creates a sorting option to be used for fetching objects.
  const SortingOption({
    required this.feature,
    required this.order,
  });

  /// A feature to apply sorting at.
  final T feature;

  /// The order in which to sort.
  final SortOrder order;

  @override
  List<Object?> get props => [feature, order];
}
