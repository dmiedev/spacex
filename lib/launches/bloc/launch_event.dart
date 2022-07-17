import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LaunchEvent extends Equatable {
  const LaunchEvent();
}

class LaunchPageRequested extends LaunchEvent {
  const LaunchPageRequested({
    required this.searchedText,
    this.firstPage = false,
  });

  final String searchedText;
  final bool firstPage;

  @override
  List<Object?> get props => [searchedText, firstPage];
}
