import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:spacex_api/spacex_api.dart';

@immutable
@JsonSerializable()
class LaunchState extends Equatable {
  const LaunchState({
    this.launches,
    required this.lastPageNumber,
    required this.hasReachedEnd,
    required this.errorOccurred,
  });

  const LaunchState.initial()
      : this(
          launches: null,
          lastPageNumber: 0,
          hasReachedEnd: false,
          errorOccurred: false,
        );

  final List<Launch>? launches;
  final int lastPageNumber;
  final bool hasReachedEnd;
  final bool errorOccurred;

  LaunchState copyWith({
    List<Launch>? Function()? launches,
    int? lastPageNumber,
    bool? hasReachedEnd,
    bool? errorOccurred,
  }) {
    return LaunchState(
      launches: launches != null ? launches() : this.launches,
      lastPageNumber: lastPageNumber ?? this.lastPageNumber,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      errorOccurred: errorOccurred ?? this.errorOccurred,
    );
  }

  // TODO(dmiedev): change toString()
  @override
  String toString() {
    return 'LaunchState(launches[${launches?.length}], $lastPageNumber, '
        '$hasReachedEnd, $errorOccurred)';
  }

  @override
  List<Object?> get props => [
        launches,
        lastPageNumber,
        hasReachedEnd,
        errorOccurred,
      ];
}
