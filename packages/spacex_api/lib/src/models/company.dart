import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

/// The SpaceX company.
@JsonSerializable(fieldRename: FieldRename.snake)
class Company extends Equatable {
  /// Creates a model containing data about the SpaceX company.
  const Company({
    required this.id,
    required this.name,
    required this.founder,
    required this.founded,
    required this.employees,
    required this.vehicles,
    required this.launchSites,
    required this.testSites,
    required this.ceo,
    required this.cto,
    required this.coo,
    required this.ctoPropulsion,
    required this.valuation,
    required this.headquarters,
    required this.links,
    required this.summary,
  });

  /// The ID of this company.
  final int id;

  /// The name of this company.
  final String name;

  /// This company founder's name.
  final String founder;

  /// The year this company was founded.
  final int founded;

  /// The number of employees in this company.
  final int employees;

  /// The number of vehicles this company owns.
  final int vehicles;

  /// The number of launch sites this company owns.
  final int launchSites;

  /// The number of test sites this company owns.
  final int testSites;

  /// The name of the chief executive officer in this company.
  final String ceo;

  /// The name of the chief technology officer in this company.
  final String cto;

  /// The name of the chief operating officer in this company.
  final String coo;

  /// The name of the chief technology officer of propulsion in this company.
  final String ctoPropulsion;

  /// This company's valuation in US dollars.
  final int valuation;

  /// This company's headquarters location.
  final CompanyEntityLocation headquarters;

  /// A collection of links to various sites related to this company.
  final CompanyLinks links;

  /// A summary of this company's activity.
  final String summary;

  @override
  List<Object?> get props => [
        id,
        name,
        founder,
        founded,
        employees,
        vehicles,
        launchSites,
        testSites,
        ceo,
        cto,
        coo,
        ctoPropulsion,
        valuation,
        headquarters,
        links,
        summary,
      ];
}

/// A location of an entity that belongs to the SpaceX company.
@JsonSerializable(fieldRename: FieldRename.snake)
class CompanyEntityLocation extends Equatable {
  /// Creates a model with location data of an entity that belongs to the SpaceX
  /// company.
  const CompanyEntityLocation({
    required this.address,
    required this.city,
    required this.state,
  });

  /// The address of the entity.
  final String address;

  /// The city that the entity is located in.
  final String city;

  /// The state that the entity is located in.
  final String state;

  @override
  List<Object?> get props => [address, city, state];
}

/// A collection of the SpaceX company's links.
@JsonSerializable(fieldRename: FieldRename.snake)
class CompanyLinks extends Equatable {
  /// Creates a collection of the SpaceX company's links.
  const CompanyLinks({
    required this.website,
    required this.flickr,
    required this.twitter,
    required this.elonTwitter,
  });

  /// The URL to the company's website.
  final String website;

  /// The URL to the company's Flickr account.
  final String flickr;

  /// The URL to the company's Twitter account.
  final String twitter;

  /// The URL to Elon Musk's Twitter account.
  final String elonTwitter;

  @override
  List<Object?> get props => [website, flickr, twitter, elonTwitter];
}
