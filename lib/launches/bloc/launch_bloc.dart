import 'package:bloc/bloc.dart';
import 'package:filter_repository/filter_repository.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:spacex/launches/bloc/bloc.dart';

/// A [Bloc] that manages the launch loading and display feature.
class LaunchBloc extends Bloc<LaunchEvent, LaunchState> {
  /// Creates a [Bloc] that manages the launch loading and display feature.
  LaunchBloc({required LaunchRepository launchRepository})
      : _launchRepository = launchRepository,
        super(const LaunchState.initial()) {
    on<LaunchPageRequested>(_handlePageRequested);
  }

  static const _amountPerPage = 10;

  final LaunchRepository _launchRepository;

  Future<void> _handlePageRequested(
    LaunchPageRequested event,
    Emitter<LaunchState> emit,
  ) async {
    if (event.pageNumber == 1) {
      emit(const LaunchState.initial());
    } else {
      emit(state.copyWith(status: LaunchStateStatus.loading));
    }
    late final LaunchState newState;
    try {
      final launches = await _launchRepository.fetchLaunches(
        amount: _amountPerPage,
        pageNumber: event.pageNumber,
        searchedPhrase:
            event.searchedText != null && event.searchedText!.isNotEmpty
                ? event.searchedText
                : null,
        sorting: event.sorting,
        filtering: [
          FilteringOption.value(
            feature: LaunchFeature.isUpcoming,
            value: event.time == LaunchTime.upcoming,
          ),
          if (event.dateInterval != null)
            FilteringOption.interval(
              feature: LaunchFeature.date,
              interval: event.dateInterval!,
            ),
          if (event.flightNumber != null && event.flightNumber != -1)
            FilteringOption.value(
              feature: LaunchFeature.flightNumber,
              value: event.flightNumber!,
            ),
          if (event.successfulness != LaunchSuccessfulness.any &&
              event.time == LaunchTime.past)
            FilteringOption.value(
              feature: LaunchFeature.isSuccessful,
              value: event.successfulness == LaunchSuccessfulness.success,
            ),
          if (event.rocketIds != null && event.rocketIds!.isNotEmpty)
            FilteringOption.anyFromValues(
              feature: LaunchFeature.rocketId,
              values: event.rocketIds!,
            ),
        ],
      );
      if (launches.isEmpty) {
        newState = LaunchState(
          launches: event.pageNumber == 1 ? [] : state.launches,
          lastPageNumber: state.lastPageNumber,
          hasReachedEnd: true,
          status: LaunchStateStatus.success,
        );
      } else {
        newState = LaunchState(
          launches: event.pageNumber == 1
              ? launches
              : [...state.launches, ...launches],
          lastPageNumber: event.pageNumber,
          hasReachedEnd: false,
          status: LaunchStateStatus.success,
        );
      }
    } on Exception {
      newState = LaunchState(
        launches: event.pageNumber == 1 ? [] : state.launches,
        lastPageNumber: state.lastPageNumber,
        hasReachedEnd: false,
        status: LaunchStateStatus.failure,
      );
    }
    emit(newState);
  }
}
