import 'package:equatable/equatable.dart';

abstract class RocketEvent extends Equatable {
  const RocketEvent();

  @override
  List<Object> get props => [];
}

class RocketLoadRequested extends RocketEvent {}
