import 'package:bloc/bloc.dart';
import 'package:spacex/home/bloc/bloc.dart';

/// A [Bloc] that manages the page navigation feature.
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  /// Creates a [Bloc] that manages the page navigation feature.
  HomeBloc() : super(const HomeState(page: HomeStatePage.launches)) {
    on<HomePageChanged>(_handlePageChanged);
  }

  void _handlePageChanged(HomePageChanged event, Emitter<HomeState> emit) {
    emit(HomeState(page: event.newPage));
  }
}
