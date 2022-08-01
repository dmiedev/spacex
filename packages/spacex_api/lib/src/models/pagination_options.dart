import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pagination_options.g.dart';

/// Order in which to sort.
enum SortOrder {
  /// Ascending order.
  ascending,

  /// Descending order.
  descending,
}

/// Options to use for pagination.
@JsonSerializable(fieldRename: FieldRename.none, includeIfNull: false)
class PaginationOptions extends Equatable {
  /// Creates options to use for pagination.
  const PaginationOptions({
    this.select,
    this.sort,
    this.offset,
    this.page,
    this.limit,
    this.pagination,
    this.populate,
  });

  /// A list of document fields to include on a page.
  final List<String>? select;

  /// A map with field names that defines pagination sort order.
  ///
  /// Field names must be specified in `snake_case`.
  final Map<String, SortOrder>? sort;

  /// The number of documents to offset the specified page.
  final int? offset;

  /// The number of page to return.
  final int? page;

  /// The number of documents per page.
  final int? limit;

  /// Whether pagination is enabled.
  ///
  /// If set to `false`, pagination query response will include all documents.
  final bool? pagination;

  /// A list of field names to populate with other documents.
  ///
  /// Field names must be specified in `snake_case`.
  final List<String>? populate;

  /// Creates a clone of this [PaginationOptions] instance with provided
  /// parameters overridden.
  PaginationOptions copyWith({
    List<String>? Function()? select,
    Map<String, SortOrder>? Function()? sort,
    int? Function()? offset,
    int? Function()? page,
    int? Function()? limit,
    bool? Function()? pagination,
    List<String>? Function()? populate,
  }) {
    return PaginationOptions(
      select: select != null ? select() : this.select,
      sort: sort != null ? sort() : this.sort,
      offset: offset != null ? offset() : this.offset,
      page: page != null ? page() : this.page,
      limit: limit != null ? limit() : this.limit,
      pagination: pagination != null ? pagination() : this.pagination,
      populate: populate != null ? populate() : this.populate,
    );
  }

  /// Converts a given JSON [Map] into a [PaginationOptions] instance.
  static PaginationOptions fromJson(Map<String, dynamic> json) {
    return _$PaginationOptionsFromJson(json);
  }

  /// Converts this [PaginationOptions] instance into a JSON [Map].
  Map<String, dynamic> toJson() => _$PaginationOptionsToJson(this);

  @override
  List<Object?> get props => [
        select,
        sort,
        offset,
        page,
        limit,
        pagination,
        populate,
      ];
}
