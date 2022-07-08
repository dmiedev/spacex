import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:spacex_api/src/models/models.dart';

part 'page.g.dart';

/// A page that contains documents of the type [T].
///
/// Currently supports JSON conversion only for documents of the [Launch] type.
@JsonSerializable(fieldRename: FieldRename.none)
class Page<T> extends Equatable {
  /// Creates a page that contains documents of type [T].
  const Page({
    required this.docs,
    required this.totalDocs,
    required this.offset,
    required this.limit,
    required this.totalPages,
    required this.page,
    required this.pagingCounter,
    required this.hasPrevPage,
    required this.hasNextPage,
    this.prevPage,
    this.nextPage,
  });

  /// A list of documents on this page.
  @_PageDocsJsonConverter<T>()
  final List<T> docs;

  /// The amount of all documents.
  final int totalDocs;

  /// The index of the first document on this page.
  final int offset;

  /// The amount of documents on this page.
  final int limit;

  /// The amount of all pages.
  final int totalPages;

  /// The number of this page.
  final int page;

  /// The paging counter.
  final int pagingCounter;

  /// Whether the previous page exists.
  final bool hasPrevPage;

  /// Whether the next page exists.
  final bool hasNextPage;

  /// The number of the previous page.
  ///
  /// Equals to `null` if the previous page does not exist.
  final int? prevPage;

  /// The number of the next page.
  ///
  /// Equals to `null` if the next page does not exist.
  final int? nextPage;

  @override
  List<Object?> get props => [
        docs,
        totalDocs,
        offset,
        limit,
        totalPages,
        page,
        pagingCounter,
        hasPrevPage,
        hasNextPage,
        prevPage,
        nextPage,
      ];

  /// Converts a given JSON [Map] into a [Page] instance.
  static Page<T> fromJson<T>(Map<String, dynamic> json) {
    return _$PageFromJson<T>(json);
  }

  /// Converts this [Page] instance into a JSON [Map].
  Map<String, dynamic> toJson() => _$PageToJson(this);

  @override
  String toString() => 'Page<${T.runtimeType}>(#$page, $limit documents)';
}

class _PageDocsJsonConverter<T> implements JsonConverter<T, Object?> {
  const _PageDocsJsonConverter();

  @override
  T fromJson(Object? json) {
    if (json is Map<String, dynamic>) {
      if (json.containsKey('flightNumber')) {
        return Launch.fromJson(json) as T;
      }
      throw UnsupportedError('Conversion of this type is not supported.');
    }
    throw ArgumentError.value(
      json,
      'json',
      'Cannot convert the provided data.',
    );
  }

  @override
  Object? toJson(T object) {
    if (object is Launch) {
      return object.toJson();
    }
    throw UnsupportedError(
      'Conversion of the ${object.runtimeType} type is not supported.',
    );
  }
}
