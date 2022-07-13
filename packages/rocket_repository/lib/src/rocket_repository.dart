import 'package:rocket_repository/exceptions.dart';
import 'package:rocket_repository/src/models/models.dart';
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
  /// Throws [RocketFetchingException] if fetching fails.
  Future<List<Rocket>> fetchAllRockets() {
    try {
      return _spacexApiClient.fetchAllRockets();
    } on Exception {
      throw RocketFetchingException();
    }
  }

  /// Fetches brief information about SpaceX rockets.
  ///
  /// Throws [RocketFetchingException] if fetching fails.
  Future<List<RocketInfo>> fetchRocketInfos() async {
    try {
      final page = await _spacexApiClient.queryRockets(
        options: const PaginationOptions(select: ['name'], pagination: false),
      );
      return page.docs
          .map((rocket) => RocketInfo(id: rocket.id, name: rocket.name!))
          .toList();
    } on Exception {
      throw RocketFetchingException();
    }
  }
}
