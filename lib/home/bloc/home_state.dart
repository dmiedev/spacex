import 'package:equatable/equatable.dart';
import 'package:spacex/home/bloc/bloc.dart';

/// The page of the app.
enum HomeStatePage {
  /// The page with rocket launches.
  launches,

  /// The page with rockets.
  rockets,
}

/// A state of the [HomeBloc].
class HomeState extends Equatable {
  /// Creates a state of the [HomeBloc].
  const HomeState({required this.page});

  /// The current page in the app.
  final HomeStatePage page;

  @override
  List<Object> get props => [page];
}
