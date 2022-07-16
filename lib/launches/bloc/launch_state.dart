import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:spacex_api/spacex_api.dart';

part 'launch_state.g.dart';

@immutable
@JsonSerializable()
class LaunchState extends Equatable {
  const LaunchState({
    required this.launches,
    required this.lastPageNumber,
    required this.lastPageAmount,
    this.hasReachedEnd = false,
    this.errorOccurred = false,
  });

  const LaunchState.initial()
      : launches = const [],
        lastPageNumber = 0,
        lastPageAmount = 0,
        hasReachedEnd = false,
        errorOccurred = false;

  final List<Launch> launches;
  final int lastPageNumber;
  final int lastPageAmount;
  final bool hasReachedEnd;
  final bool errorOccurred;

  LaunchState copyWith({
    List<Launch>? launches,
    int? lastPageNumber,
    int? lastPageAmount,
    bool? hasReachedEnd,
    bool? errorOccurred,
  }) {
    return LaunchState(
      launches: launches ?? this.launches,
      lastPageNumber: lastPageNumber ?? this.lastPageNumber,
      lastPageAmount: lastPageAmount ?? this.lastPageAmount,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      errorOccurred: errorOccurred ?? this.errorOccurred,
    );
  }

  static LaunchState fromJson(Map<String, dynamic> json) {
    return _$LaunchStateFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LaunchStateToJson(this);

  @override
  String toString() {
    return 'LaunchState(launches[${launches.length}], $lastPageNumber, '
        '$lastPageAmount, $hasReachedEnd, $errorOccurred)';
  }

  @override
  List<Object?> get props => [
        launches,
        lastPageAmount,
        lastPageNumber,
        hasReachedEnd,
        errorOccurred,
      ];
}
