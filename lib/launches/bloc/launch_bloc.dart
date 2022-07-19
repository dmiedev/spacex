import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:spacex/launches/bloc/bloc.dart';
import 'package:spacex_api/spacex_api.dart';

class LaunchBloc extends Bloc<LaunchEvent, LaunchState> {
  LaunchBloc({required LaunchRepository launchRepository})
      : _launchRepository = launchRepository,
        super(const LaunchState.initial()) {
    on<LaunchPageRequested>(_handlePageRequested);
    on<LaunchSortingOptionAdded>(_handleSortingOptionAdded);
    on<LaunchSortingOrderSwitched>(_handleSortingOrderSwitched);
    on<LaunchTimeFilteringSwitched>(_handleTimeFilteringSwitched);
  }

  static const _amountPerPage = 10;

  final LaunchRepository _launchRepository;

  Future<LaunchState> _fetchNewState({
    required int pageNumber,
    required String searchedText,
    required SortingOption sortingOption,
    required LaunchTimeFiltering timeFiltering,
  }) async {
    try {
      final launches = await _launchRepository.fetchLaunches(
        amount: _amountPerPage,
        listNumber: pageNumber,
        searchedText: searchedText.isNotEmpty ? searchedText : null,
        sorting: sortingOption,
        filtering: [
          FilteringOption.value(
            feature: LaunchFeature.isUpcoming,
            value: timeFiltering == LaunchTimeFiltering.upcoming,
          ),
        ],
      );
      if (launches.isEmpty) {
        return LaunchState(
          launches: pageNumber == 1 ? [] : state.launches,
          lastPageNumber: state.lastPageNumber,
          hasReachedEnd: true,
          errorOccurred: false,
          searchedText: searchedText,
          timeFiltering: timeFiltering,
          sortingOption: sortingOption,
        );
      }
      return LaunchState(
        launches:
            pageNumber == 1 ? launches : [...?state.launches, ...launches],
        lastPageNumber: pageNumber,
        hasReachedEnd: false,
        errorOccurred: false,
        searchedText: searchedText,
        timeFiltering: timeFiltering,
        sortingOption: sortingOption,
      );
    } on Exception {
      return LaunchState(
        launches: pageNumber == 1 ? [] : state.launches,
        lastPageNumber: pageNumber,
        hasReachedEnd: false,
        errorOccurred: true,
        searchedText: searchedText,
        timeFiltering: timeFiltering,
        sortingOption: sortingOption,
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
      sortingOption: state.sortingOption,
      timeFiltering: state.timeFiltering,
    );
    emit(newState);
  }

  Future<void> _handleSortingOptionAdded(
    LaunchSortingOptionAdded event,
    Emitter<LaunchState> emit,
  ) async {
    final sortingOption = SortingOption(
      feature: event.feature,
      order: state.sortingOption.order,
    );
    emit(
      const LaunchState.initial().copyWith(
        searchedText: state.searchedText,
        sortingOption: sortingOption,
        timeFiltering: state.timeFiltering,
      ),
    );
    final newState = await _fetchNewState(
      pageNumber: 1,
      searchedText: state.searchedText,
      sortingOption: sortingOption,
      timeFiltering: state.timeFiltering,
    );
    emit(newState);
  }

  void _handleSortingOrderSwitched(
    LaunchSortingOrderSwitched event,
    Emitter<LaunchState> emit,
  ) async {
    final sortingOption = SortingOption(
      feature: state.sortingOption.feature,
      order: state.sortingOption.order == SortOrder.ascending
          ? SortOrder.descending
          : SortOrder.ascending,
    );
    emit(
      const LaunchState.initial().copyWith(
        searchedText: state.searchedText,
        sortingOption: sortingOption,
        timeFiltering: state.timeFiltering,
      ),
    );
    final newState = await _fetchNewState(
      pageNumber: 1,
      searchedText: state.searchedText,
      sortingOption: sortingOption,
      timeFiltering: state.timeFiltering,
    );
    emit(newState);
  }

  Future<void> _handleTimeFilteringSwitched(
    LaunchTimeFilteringSwitched event,
    Emitter<LaunchState> emit,
  ) async {
    final timeFiltering = state.timeFiltering == LaunchTimeFiltering.upcoming
        ? LaunchTimeFiltering.past
        : LaunchTimeFiltering.upcoming;
    emit(
      const LaunchState.initial().copyWith(
        searchedText: state.searchedText,
        sortingOption: state.sortingOption,
        timeFiltering: timeFiltering,
      ),
    );
    final newState = await _fetchNewState(
      pageNumber: 1,
      searchedText: state.searchedText,
      sortingOption: state.sortingOption,
      timeFiltering: timeFiltering,
    );
    emit(newState);
  }
}
