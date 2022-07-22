import 'package:bloc/bloc.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:rocket_repository/rocket_repository.dart';
import 'package:spacex/launch_filtering/bloc/bloc.dart';
import 'package:spacex_api/spacex_api.dart';

class LaunchFilteringBloc
    extends Bloc<LaunchFilteringEvent, LaunchFilteringState> {
  LaunchFilteringBloc({required RocketRepository rocketRepository})
      : _rocketRepository = rocketRepository,
        super(const LaunchFilteringState.initial()) {
    on<LaunchFilteringSearchedTextSubmitted>(_handleSearchedTextSubmitted);
    on<LaunchFilteringSortingSelected>(_handleSortingSelected);
    on<LaunchFilteringSortingOrderSwitched>(_handleSortingOrderSwitched);
    on<LaunchFilteringTimeSwitched>(_handleTimeSwitched);
    on<LaunchFilteringFlightNumberSet>(_handleFlightNumberSet);
    on<LaunchFilteringDateIntervalSet>(_handleDateIntervalSet);
    on<LaunchFilteringSuccessfulnessSelected>(_handleSuccessfulnessSelected);
    on<LaunchFilteringRocketsRequested>(_handleRocketsRequested);
    on<LaunchFilteringRocketsSelected>(_handleRocketsSelected);
  }

  final RocketRepository _rocketRepository;

  void _handleSearchedTextSubmitted(
    LaunchFilteringSearchedTextSubmitted event,
    Emitter<LaunchFilteringState> emit,
  ) {
    emit(state.copyWith(searchedText: event.searchedText));
  }

  void _handleSortingSelected(
    LaunchFilteringSortingSelected event,
    Emitter<LaunchFilteringState> emit,
  ) {
    emit(
      state.copyWith(
        sorting: SortingOption(
          feature: event.feature,
          order: state.sorting.order,
        ),
      ),
    );
  }

  void _handleSortingOrderSwitched(
    LaunchFilteringSortingOrderSwitched event,
    Emitter<LaunchFilteringState> emit,
  ) {
    emit(
      state.copyWith(
        sorting: SortingOption(
          feature: state.sorting.feature,
          order: state.sorting.order == SortOrder.ascending
              ? SortOrder.descending
              : SortOrder.ascending,
        ),
      ),
    );
  }

  void _handleTimeSwitched(
    LaunchFilteringTimeSwitched event,
    Emitter<LaunchFilteringState> emit,
  ) {
    emit(
      state.copyWith(
        time: state.time == LaunchTime.upcoming
            ? LaunchTime.past
            : LaunchTime.upcoming,
        successfulness: LaunchSuccessfulness.any,
      ),
    );
  }

  void _handleDateIntervalSet(
    LaunchFilteringDateIntervalSet event,
    Emitter<LaunchFilteringState> emit,
  ) {
    emit(state.copyWith(dateInterval: () => event.dateInterval));
  }

  void _handleFlightNumberSet(
    LaunchFilteringFlightNumberSet event,
    Emitter<LaunchFilteringState> emit,
  ) {
    emit(state.copyWith(flightNumber: event.flightNumber));
  }

  void _handleSuccessfulnessSelected(
    LaunchFilteringSuccessfulnessSelected event,
    Emitter<LaunchFilteringState> emit,
  ) {
    emit(state.copyWith(successfulness: event.successfulness));
  }

  Future<void> _handleRocketsRequested(
    LaunchFilteringRocketsRequested event,
    Emitter<LaunchFilteringState> emit,
  ) async {
    if (state.allRocketsAreLoaded) {
      return;
    }
    emit(state.copyWith(allRockets: () => null));
    late final List<RocketInfo> rockets;
    try {
      rockets = await _rocketRepository.fetchRocketInfos();
    } on Exception {
      rockets = [];
    }
    emit(state.copyWith(allRockets: () => rockets));
  }

  Future<void> _handleRocketsSelected(
    LaunchFilteringRocketsSelected event,
    Emitter<LaunchFilteringState> emit,
  ) async {
    emit(state.copyWith(rockets: event.rockets));
  }
}
