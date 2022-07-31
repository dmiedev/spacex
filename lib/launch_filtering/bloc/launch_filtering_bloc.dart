import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:rocket_repository/rocket_repository.dart';
import 'package:spacex/launch_filtering/bloc/bloc.dart';
import 'package:spacex_api/spacex_api.dart';

/// A [Bloc] that manages the launch filtering feature.
class LaunchFilteringBloc
    extends Bloc<LaunchFilteringEvent, LaunchFilteringState> {
  /// Creates a [Bloc] that manages the launch filtering feature.
  LaunchFilteringBloc({
    required RocketRepository rocketRepository,
    required LaunchRepository launchRepository,
  })  : _rocketRepository = rocketRepository,
        _launchRepository = launchRepository,
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
    on<LaunchFilteringSaved>(_handleSaved);
    on<LaunchFilteringLoaded>(_handleLoaded);
  }

  final RocketRepository _rocketRepository;
  final LaunchRepository _launchRepository;

  void _handleSearchedTextSubmitted(
    LaunchFilteringSearchedTextSubmitted event,
    Emitter<LaunchFilteringState> emit,
  ) {
    emit(
      state.copyWith(
        filtering:
            state.filtering.copyWith(searchedPhrase: event.searchedPhrase),
      ),
    );
  }

  void _handleSortingSelected(
    LaunchFilteringSortingSelected event,
    Emitter<LaunchFilteringState> emit,
  ) {
    emit(
      state.copyWith(
        sorting: Sorting<LaunchSortingParameter>(
          parameter: event.sortingParameter,
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
        sorting: Sorting<LaunchSortingParameter>(
          parameter: state.sorting.parameter,
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
    final newTime = state.filtering.time == LaunchTime.upcoming
        ? LaunchTime.past
        : LaunchTime.upcoming;
    emit(
      state.copyWith(filtering: state.filtering.copyWith(time: () => newTime)),
    );
  }

  void _handleDateIntervalSet(
    LaunchFilteringDateIntervalSet event,
    Emitter<LaunchFilteringState> emit,
  ) {
    emit(
      state.copyWith(
        filtering: state.filtering.copyWith(
          dateInterval: () => event.dateInterval,
        ),
      ),
    );
  }

  void _handleFlightNumberSet(
    LaunchFilteringFlightNumberSet event,
    Emitter<LaunchFilteringState> emit,
  ) {
    emit(
      state.copyWith(
        filtering: state.filtering.copyWith(
          flightNumber: () => event.flightNumber,
        ),
      ),
    );
  }

  void _handleSuccessfulnessSelected(
    LaunchFilteringSuccessfulnessSelected event,
    Emitter<LaunchFilteringState> emit,
  ) {
    emit(
      state.copyWith(
        filtering:
            state.filtering.copyWith(successfulness: event.successfulness),
      ),
    );
  }

  Future<void> _handleRocketsSelected(
    LaunchFilteringRocketsSelected event,
    Emitter<LaunchFilteringState> emit,
  ) async {
    if (state.allRockets == null) {
      return;
    }
    final rocketIds = <String>[];
    for (var index = 0; index < event.rocketSelection.length; index++) {
      if (event.rocketSelection[index]) {
        rocketIds.add(state.allRockets![index].id);
      }
    }
    emit(
      state.copyWith(filtering: state.filtering.copyWith(rocketIds: rocketIds)),
    );
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

  Future<void> _handleSaved(
    LaunchFilteringSaved event,
    Emitter<LaunchFilteringState> emit,
  ) async {
    try {
      await _launchRepository.saveFiltering(state.filtering);
      emit(state.copyWith(status: LaunchFilteringSaveLoadStatus.saveSuccess));
    } on Exception {
      emit(state.copyWith(status: LaunchFilteringSaveLoadStatus.saveFailure));
    }
  }

  void _handleLoaded(
    LaunchFilteringLoaded event,
    Emitter<LaunchFilteringState> emit,
  ) {
    try {
      final filtering = _launchRepository.loadFiltering();
      emit(
        state.copyWith(
          filtering: filtering,
          status: LaunchFilteringSaveLoadStatus.loadSuccess,
        ),
      );
    } on Exception {
      emit(state.copyWith(status: LaunchFilteringSaveLoadStatus.loadFailure));
    }
  }
}
