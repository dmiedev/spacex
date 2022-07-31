import 'package:equatable/equatable.dart';
import 'package:filtered_repository/src/models/models.dart';

/// A collections of parameters used to filter queried objects.
class FilterParameters<T extends Feature> extends Equatable {
  /// Creates a collections of parameters used to filter queried objects.
  const FilterParameters({
    this.filtering = const [],
    this.sorting,
    this.searchedPhrase,
  });

  /// A list of filtering options to use.
  final List<FilteringOption<T>> filtering;

  /// A sorting option to use.
  final SortingOption<T>? sorting;

  /// A phrase to search in objects' String fields.
  final String? searchedPhrase;

  @override
  List<Object?> get props => [filtering, sorting, searchedPhrase];
}
