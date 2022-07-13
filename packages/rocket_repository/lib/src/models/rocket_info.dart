import 'package:equatable/equatable.dart';

/// Brief information about a particular rocket.
class RocketInfo extends Equatable {
  /// Creates a model that contains brief information about a particular rocket.
  const RocketInfo({
    required this.id,
    required this.name,
  });

  /// The ID of the rocket.
  final String id;

  /// THe name of the rocket.
  final String name;

  @override
  List<Object?> get props => [id, name];
}
