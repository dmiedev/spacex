import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rocket.g.dart';

/// A SpaceX rocket.
///
/// This data model is not yet fully implemented.
@JsonSerializable(fieldRename: FieldRename.snake)
class Rocket extends Equatable {
  /// Creates a model that contains data about a SpaceX rocket.
  const Rocket({
    required this.id,
    this.name,
    this.active,
    this.stages,
    this.boosters,
    this.costPerLaunch,
    this.successRatePct,
    this.firstFlight,
    this.country,
    this.company,
    this.height,
    this.diameter,
    this.mass,
    this.flickrImages,
    this.wikipedia,
    this.description,
  });

  /// The ID of this rocket.
  final String id;

  /// The name of this rocket.
  final String? name;

  /// Whether this rocket is currently in use.
  final bool? active;

  /// The number of stages this rocket has.
  final int? stages;

  /// The number of boosters this rocket has.
  final int? boosters;

  /// The amount in US dollars it costs on average to launch this rocket.
  final int? costPerLaunch;

  /// The launch success rate of this rocket in percents.
  final int? successRatePct;

  /// The date this rocket was first launched.
  final DateTime? firstFlight;

  /// The country that this rocket was first launched from.
  final String? country;

  /// The company that this rocket belongs to.
  final String? company;

  /// The height of this rocket.
  final Length? height;

  /// The diameter of this rocket.
  final Length? diameter;

  /// The mass of this rocket.
  final Mass? mass;

  /// A list of URLs to Flickr images of this rocket.
  final List<String>? flickrImages;

  /// A URL to the Wikipedia article about this rocket.
  final String? wikipedia;

  /// A description of this rocket.
  final String? description;

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

  /// Converts a given JSON [Map] into a [Rocket] instance.
  static Rocket fromJson(Map<String, dynamic> json) => _$RocketFromJson(json);

  /// Converts this [Rocket] instance into a JSON [Map].
  Map<String, dynamic> toJson() => _$RocketToJson(this);

  @override
  String toString() => 'Rocket($id, $name)';
}

/// A certain length in meters and feet.
@JsonSerializable(fieldRename: FieldRename.snake)
class Length extends Equatable {
  /// Creates a model that represents a certain length in meters and feet.
  const Length({
    this.meters,
    this.feet,
  });

  /// This length in SI meters.
  final double? meters;

  /// This length in imperial feet.
  final double? feet;

  @override
  List<Object?> get props => [meters, feet];

  /// Converts a given JSON [Map] into a [Length] instance.
  static Length fromJson(Map<String, dynamic> json) => _$LengthFromJson(json);

  /// Converts this [Length] instance into a JSON [Map].
  Map<String, dynamic> toJson() => _$LengthToJson(this);

  @override
  String toString() => 'Length($meters m, $feet ft)';
}

/// A certain mass in kilograms and pounds.
@JsonSerializable(fieldRename: FieldRename.snake)
class Mass extends Equatable {
  /// Creates a model that represents a certain mass in kilograms and pounds.
  const Mass({
    this.kg,
    this.lb,
  });

  /// This mass in SI kilograms.
  final int? kg;

  /// This mass in imperial pounds.
  final int? lb;

  @override
  List<Object?> get props => [kg, lb];

  /// Converts a given JSON [Map] into a [Mass] instance.
  static Mass fromJson(Map<String, dynamic> json) => _$MassFromJson(json);

  /// Converts this [Mass] instance into a JSON [Map].
  Map<String, dynamic> toJson() => _$MassToJson(this);

  @override
  String toString() => 'Mass($kg kg, $lb lb)';
}
