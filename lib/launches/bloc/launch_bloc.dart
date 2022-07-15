import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:spacex/launches/bloc/bloc.dart';

class LaunchBloc extends Bloc<LaunchEvent, LaunchState> {
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
    try {
      final launches = await _launchRepository.fetchLaunches(
        amount: _amountPerPage,
        listNumber: state.lastPageNumber + 1,
      );
      emit(
        LaunchState(
          launches: [...state.launches, ...launches],
          lastPageNumber: state.lastPageNumber + 1,
          lastPageAmount: launches.length,
        ),
      );
    } on Exception {
      emit(
        state.copyWith(errorOccurred: true),
      );
    }
  }

  // @override
  // LaunchState? fromJson(Map<String, dynamic> json) {
  //   return LaunchState.fromJson(json);
  // }

  // @override
  // Map<String, dynamic>? toJson(LaunchState state) => state.toJson();
}
