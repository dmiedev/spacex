import 'package:bloc/bloc.dart';
import 'package:rocket_repository/rocket_repository.dart';
import 'package:spacex/rockets/bloc/bloc.dart';

class RocketBloc extends Bloc<RocketEvent, RocketState> {
  RocketBloc({required RocketRepository rocketRepository})
      : _rocketRepository = rocketRepository,
        super(RocketInitial()) {
    on<RocketLoadRequested>(_handleLoadRequested);
  }

  final RocketRepository _rocketRepository;

  Future<void> _handleLoadRequested(
    RocketLoadRequested event,
    Emitter<RocketState> emit,
  ) async {
    emit(RocketLoadInProgress());
    try {
      final rockets = await _rocketRepository.fetchAllRockets();
      emit(RocketLoadSuccess(rockets: rockets));
    } on Exception {
      emit(RocketLoadFailure());
    }
  }
}
