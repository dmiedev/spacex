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
    // required FilterRepository filterRepository,
  })  : _rocketRepository = rocketRepository,
        // _filterRepository = filterRepository,
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
    on<LaunchFilteringLoaded>(_handleLoaded);
    on<LaunchFilteringSaved>(_handleSaved);
  }

  final RocketRepository _rocketRepository;
  // final FilterRepository _filterRepository;

  void _handleSearchedTextSubmitted(
    LaunchFilteringSearchedTextSubmitted event,
    Emitter<LaunchFilteringState> emit,
  ) {
    emit(
      state.copyWith(searchedText: event.searchedText),
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
    emit(
      state.copyWith(
        time: state.time == LaunchTime.upcoming
            ? LaunchTime.past
            : LaunchTime.upcoming,
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
    emit(state.copyWith(flightNumber: () => event.flightNumber));
  }

  void _handleSuccessfulnessSelected(
    LaunchFilteringSuccessfulnessSelected event,
    Emitter<LaunchFilteringState> emit,
  ) {
    emit(state.copyWith(successfulness: event.successfulness));
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
    emit(state.copyWith(rocketIds: rocketIds));
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

  Future<void> _handleLoaded(
    LaunchFilteringLoaded event,
    Emitter<LaunchFilteringState> emit,
  ) async {
    // try {
    //   final parameters = await _filterRepository.getLaunchFilters();
    //   if (parameters == null) {
    //     emit(
    //       state.copyWith(status: LaunchFilteringSaveLoadStatus.loadedNothing),
    //     );
    //     return;
    //   }
    //   emit(
    //     state.copyWith(
    //       time: parameters.time,
    //       dateInterval: parameters.fromDate != null && parameters.toDate != null
    //           ? () => DateTimeInterval(
    //                 from: parameters.fromDate!,
    //                 to: parameters.toDate!,
    //               )
    //           : null,
    //       flightNumber: () => parameters.flightNumber,
    //       successfulness: parameters.successfulness,
    //       rocketIds: parameters.rocketIds,
    //       status: LaunchFilteringSaveLoadStatus.loadSuccess,
    //     ),
    //   );
    // } on Exception {
    //   emit(state.copyWith(status: LaunchFilteringSaveLoadStatus.loadFailure));
    // }
  }

  Future<void> _handleSaved(
    LaunchFilteringSaved event,
    Emitter<LaunchFilteringState> emit,
  ) async {
    // try {
    //   await _filterRepository.saveLaunchFilters(
    //     LaunchFilters(
    //       time: state.time,
    //       fromDate:
    //           state.dateInterval != null ? state.dateInterval!.from : null,
    //       toDate: state.dateInterval != null ? state.dateInterval!.to : null,
    //       flightNumber: state.flightNumber,
    //       successfulness: state.successfulness,
    //       rocketIds: state.rocketIds,
    //     ),
    //   );
    //   emit(state.copyWith(status: LaunchFilteringSaveLoadStatus.saveSuccess));
    // } on Exception {
    //   emit(state.copyWith(status: LaunchFilteringSaveLoadStatus.saveFailure));
    // }
  }
}
