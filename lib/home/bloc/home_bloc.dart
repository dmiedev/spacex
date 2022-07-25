import 'package:bloc/bloc.dart';
import 'package:spacex/home/bloc/bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState(page: HomeStatePage.launches)) {
    on<HomePageChanged>(_handlePageChanged);
  }

  void _handlePageChanged(HomePageChanged event, Emitter<HomeState> emit) {
    emit(HomeState(page: event.newPage));
  }
}
