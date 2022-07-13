import 'package:rocket_repository/exceptions.dart';
import 'package:spacex_api/spacex_api.dart';

/// A repository that manages the rocket domain.
class RocketRepository {
  /// Creates a repository that manages the rocket launch domain.
  RocketRepository({
    SpacexApiClient? spacexApiClient,
  }) : _spacexApiClient = spacexApiClient ?? SpacexApiClient();

  final SpacexApiClient _spacexApiClient;

  /// Fetches SpaceX rockets.
  ///
  /// Throws [RocketsFetchException] if fetching fails.
  Future<List<Rocket>> fetchAllRockets() {
    try {
      return _spacexApiClient.fetchAllRockets();
    } on Exception {
      throw RocketsFetchException();
    }
  }
}
