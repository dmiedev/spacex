import 'package:equatable/equatable.dart';
import 'package:launch_repository/src/models/models.dart';
import 'package:spacex_api/spacex_api.dart';

/// A sorting option to be used for fetching launches.
class SortingOption extends Equatable {
  /// Creates a sorting option to be used for fetching launches.
  const SortingOption({
    required this.feature,
    required this.order,
  });

  /// A launch feature to apply sorting at.
  final LaunchFeature feature;

  /// The order in which to sort.
  final SortOrder order;

  @override
  List<Object?> get props => [feature, order];
}
