import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:spacex_api/spacex_api.dart';

enum LaunchStateStatus { success, loading, failure }

@immutable
@JsonSerializable()
class LaunchState extends Equatable {
  const LaunchState({
    required this.launches,
    required this.lastPageNumber,
    required this.hasReachedEnd,
    required this.status,
  });

  const LaunchState.initial()
      : this(
          launches: const [],
          lastPageNumber: 0,
          hasReachedEnd: false,
          status: LaunchStateStatus.loading,
        );

  final List<Launch> launches;
  final int lastPageNumber;
  final bool hasReachedEnd;
  final LaunchStateStatus status;

  LaunchState copyWith({
    List<Launch>? launches,
    int? lastPageNumber,
    bool? hasReachedEnd,
    LaunchStateStatus? status,
  }) {
    return LaunchState(
      launches: launches ?? this.launches,
      lastPageNumber: lastPageNumber ?? this.lastPageNumber,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      status: status ?? this.status,
    );
  }

  // TODO(dmiedev): change toString()
  @override
  String toString() {
    return 'LaunchState(launches[${launches.length}], $lastPageNumber, '
        '$hasReachedEnd, $status)';
  }

  @override
  List<Object?> get props => [
        launches,
        lastPageNumber,
        hasReachedEnd,
        status,
      ];
}
