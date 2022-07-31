import 'package:bloc/bloc.dart';
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
      // Clear everything that was loaded so far.
      emit(const LaunchState.initial());
    } else {
      emit(state.copyWith(status: LaunchStateStatus.loading));
    }
    late final LaunchState newState;
    try {
      final launches = await _launchRepository.fetchFiltered(
        amount: _amountPerPage,
        pageNumber: event.pageNumber,
        sorting: event.sorting,
        filtering: LaunchFiltering(
          searchedPhrase: event.searchedPhrase,
          time: event.time,
          dateInterval: event.dateInterval,
          flightNumber: event.flightNumber,
          successfulness: event.successfulness,
          rocketIds: event.rocketIds,
        ),
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
