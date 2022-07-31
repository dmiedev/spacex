import 'package:bloc/bloc.dart';
import 'package:rocket_repository/rocket_repository.dart';
import 'package:spacex/rockets/bloc/bloc.dart';

/// A [Bloc] that manages the rocket display feature.
class RocketBloc extends Bloc<RocketEvent, RocketState> {
  /// Creates a [Bloc] that manages the rocket display feature.
  RocketBloc({required RocketRepository rocketRepository})
      : _rocketRepository = rocketRepository,
        super(const RocketInitial()) {
    on<RocketLoadRequested>(_handleLoadRequested);
  }

  final RocketRepository _rocketRepository;

  Future<void> _handleLoadRequested(
    RocketLoadRequested event,
    Emitter<RocketState> emit,
  ) async {
    emit(const RocketLoadInProgress());
    try {
      final rockets = await _rocketRepository.fetchAllRockets();
      emit(RocketLoadSuccess(rockets: rockets));
    } on Exception {
      emit(const RocketLoadFailure());
    }
  }
}
