// ignore_for_file: inference_failure_on_instance_creation

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:spacex_api/src/models/models.dart';

part 'page.g.dart';

/// A page that contains documents of the type [T].
///
/// Currently supports JSON conversion only for documents of [Launch] and
/// [Rocket] generic types.
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
  @_PageDocsJsonConverter()
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
  ///
  /// This currently only supports [Page] instances of [Launch] and [Rocket]
  /// generic types.
  static Page<T> fromJson<T>(Map<String, dynamic> json) {
    return _$PageFromJson<T>(json);
  }

  /// Converts this [Page] instance into a JSON [Map].
  ///
  /// This currently only supports [Page] instances of [Launch] and [Rocket]
  /// generic types.
  Map<String, dynamic> toJson() => _$PageToJson(this);

  @override
  String toString() => 'Page<${T.runtimeType}>(#$page, $limit documents)';
}

class _PageDocsJsonConverter<T>
    implements JsonConverter<T, Map<String, dynamic>> {
  const _PageDocsJsonConverter();

  @override
  T fromJson(Map<String, dynamic> json) {
    if (json.containsKey('flight_number')) {
      return Launch.fromJson(json) as T;
    } else if (json.containsKey('success_rate_pct')) {
      return Rocket.fromJson(json) as T;
    }
    throw UnsupportedError('Conversion of this type is not supported.');
  }

  @override
  Map<String, dynamic> toJson(T object) {
    if (object is Launch) {
      return object.toJson();
    } else if (object is Rocket) {
      return object.toJson();
    }
    throw UnsupportedError(
      'Conversion of the ${object.runtimeType} type is not supported.',
    );
  }
}
