import 'package:equatable/equatable.dart';

enum HomeStatePage { launches, rockets }

class HomeState extends Equatable {
  const HomeState({required this.page});

  final HomeStatePage page;

  @override
  List<Object> get props => [page];
}
