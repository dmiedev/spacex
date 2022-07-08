import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

/// A SpaceX rocket.
@JsonSerializable(fieldRename: FieldRename.snake)
class Rocket extends Equatable {
  /// Creates a model that contains data about a SpaceX rocket.
  const Rocket({
    required this.id,
    required this.name,
    required this.active,
    required this.stages,
    required this.boosters,
    required this.costPerLaunch,
    required this.successRatePct,
    required this.firstFlight,
    required this.country,
    required this.company,
    required this.height,
    required this.diameter,
    required this.mass,
    required this.flickrImages,
    required this.wikipedia,
    required this.description,
  });

  /// The ID of this rocket.
  final String id;

  /// The name of this rocket.
  final String name;

  /// Whether this rocket is currently in use.
  final bool active;

  /// The number of stages this rocket has.
  final int stages;

  /// The number of boosters this rocket has.
  final int boosters;

  /// The amount in US dollars it costs on average to launch this rocket.
  final int costPerLaunch;

  /// The launch success rate of this rocket in percents.
  final int successRatePct;

  /// The date this rocket was first launched.
  final DateTime firstFlight;

  /// The country that this rocket was first launched from.
  final String country;

  /// The company that this rocket belongs to.
  final String company;

  /// The height of this rocket.
  final Length height;

  /// The diameter of this rocket.
  final Length diameter;

  /// The mass of this rocket.
  final Mass mass;

  /// A list of URLs to Flickr images of this rocket.
  final List<String> flickrImages;

  /// A URL to the Wikipedia article about this rocket.
  final String wikipedia;

  /// A description of this rocket.
  final String description;

  @override
  List<Object?> get props => [
        id,
        name,
        active,
        stages,
        boosters,
        costPerLaunch,
        successRatePct,
        firstFlight,
        country,
        company,
        height,
        diameter,
        mass,
        flickrImages,
        wikipedia,
        description,
      ];

  @override
  String toString() => 'Rocket($id, $name)';
}

/// A certain length in meters and feet.
@JsonSerializable(fieldRename: FieldRename.snake)
class Length extends Equatable {
  /// Creates a model that represents a certain length in meters and feet.
  const Length({
    required this.meters,
    required this.feet,
  });

  /// This length in SI meters.
  final double meters;

  /// This length in imperial feet.
  final double feet;

  @override
  List<Object?> get props => [meters, feet];

  @override
  String toString() => 'Length($meters m, $feet ft)';
}

/// A certain mass in kilograms and pounds.
@JsonSerializable(fieldRename: FieldRename.snake)
class Mass extends Equatable {
  /// Creates a model that represents a certain mass in kilograms and pounds.
  const Mass({
    required this.kg,
    required this.lb,
  });

  /// This mass in SI kilograms.
  final int kg;

  /// This mass in imperial pounds.
  final int lb;

  @override
  List<Object?> get props => [kg, lb];

  @override
  String toString() => 'Mass($kg kg, $lb lb)';
}
