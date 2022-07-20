import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:spacex/launches/bloc/bloc.dart';
import 'package:spacex_api/spacex_api.dart';

class LaunchBloc extends Bloc<LaunchEvent, LaunchState> {
  LaunchBloc({required LaunchRepository launchRepository})
      : _launchRepository = launchRepository,
        super(const LaunchState.initial()) {
    on<LaunchPageRequested>(_handlePageRequested);
    on<LaunchSortingSelected>(_handleSortingSelected);
    on<LaunchSortingOrderSwitched>(_handleSortingOrderSwitched);
    on<LaunchTimeSwitched>(_handleTimeSwitched);
    on<LaunchFlightNumberSet>(_handleFlightNumberSet);
    on<LaunchSuccessfulnessSelected>(_handleSuccessfulnessSelected);
  }

  static const _amountPerPage = 10;

  final LaunchRepository _launchRepository;

  Future<LaunchState> _fetchNewState({
    int pageNumber = 1,
    String? searchedText,
  }) async {
    searchedText ??= state.searchedText;
    try {
      final launches = await _launchRepository.fetchLaunches(
        amount: _amountPerPage,
        listNumber: pageNumber,
        searchedText: searchedText.isNotEmpty ? searchedText : null,
        sorting: state.sorting,
        filtering: [
          FilteringOption.value(
            feature: LaunchFeature.isUpcoming,
            value: state.time == LaunchTime.upcoming,
          ),
          if (state.successfulness != LaunchSuccessfulness.any &&
              state.time == LaunchTime.past)
            FilteringOption.value(
              feature: LaunchFeature.isSuccessful,
              value: state.successfulness == LaunchSuccessfulness.success,
            ),
          if (state.flightNumber != -1)
            FilteringOption.value(
              feature: LaunchFeature.flightNumber,
              value: state.flightNumber,
            ),
        ],
      );
      if (launches.isEmpty) {
        return state.copyWith(
          launches: pageNumber == 1 ? [] : state.launches,
          lastPageNumber: state.lastPageNumber,
          hasReachedEnd: true,
          errorOccurred: false,
          searchedText: searchedText,
        );
      }
      return state.copyWith(
        launches:
            pageNumber == 1 ? launches : [...?state.launches, ...launches],
        lastPageNumber: pageNumber,
        hasReachedEnd: false,
        errorOccurred: false,
        searchedText: searchedText,
      );
    } on Exception {
      return state.copyWith(
        launches: pageNumber == 1 ? null : state.launches,
        lastPageNumber: pageNumber,
        hasReachedEnd: false,
        errorOccurred: true,
        searchedText: searchedText,
      );
    }
  }

  Future<void> _handlePageRequested(
    LaunchPageRequested event,
    Emitter<LaunchState> emit,
  ) async {
    final newState = await _fetchNewState(
      pageNumber: !event.firstPage ? state.lastPageNumber + 1 : 1,
      searchedText: event.searchedText,
    );
    emit(newState);
  }

  Future<void> _handleSortingSelected(
    LaunchSortingSelected event,
    Emitter<LaunchState> emit,
  ) async {
    final sortingOption = SortingOption(
      feature: event.feature,
      order: state.sorting.order,
    );
    emit(state.getEmpty(sorting: sortingOption));
    final newState = await _fetchNewState();
    emit(newState);
  }

  Future<void> _handleSortingOrderSwitched(
    LaunchSortingOrderSwitched event,
    Emitter<LaunchState> emit,
  ) async {
    final sortingOption = SortingOption(
      feature: state.sorting.feature,
      order: state.sorting.order == SortOrder.ascending
          ? SortOrder.descending
          : SortOrder.ascending,
    );
    emit(state.getEmpty(sorting: sortingOption));
    final newState = await _fetchNewState();
    emit(newState);
  }

  Future<void> _handleTimeSwitched(
    LaunchTimeSwitched event,
    Emitter<LaunchState> emit,
  ) async {
    final timeFiltering = state.time == LaunchTime.upcoming
        ? LaunchTime.past
        : LaunchTime.upcoming;
    emit(
      state.getEmpty(
        time: timeFiltering,
        successfulness: LaunchSuccessfulness.any,
      ),
    );
    final newState = await _fetchNewState();
    emit(newState);
  }

  Future<void> _handleSuccessfulnessSelected(
    LaunchSuccessfulnessSelected event,
    Emitter<LaunchState> emit,
  ) async {
    emit(state.getEmpty(successfulness: event.successfulness));
    final newState = await _fetchNewState();
    emit(newState);
  }

  Future<void> _handleFlightNumberSet(
    LaunchFlightNumberSet event,
    Emitter<LaunchState> emit,
  ) async {
    emit(state.getEmpty(flightNumber: event.flightNumber));
    final newState = await _fetchNewState();
    emit(newState);
  }
}
