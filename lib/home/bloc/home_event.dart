import 'package:equatable/equatable.dart';
import 'package:spacex/home/bloc/bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomePageChanged extends HomeEvent {
  const HomePageChanged({required this.newPage});

  final HomeStatePage newPage;

  @override
  List<Object> get props => [newPage];
}
