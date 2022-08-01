import 'package:company_repository/src/exceptions.dart';
import 'package:spacex_api/spacex_api.dart';

/// A repository that manages the company domain.
class CompanyRepository {
  /// Creates a repository that manages the company domain.
  CompanyRepository({
    SpacexApiClient? spacexApiClient,
  }) : _spacexApiClient = spacexApiClient ?? SpacexApiClient();

  final SpacexApiClient _spacexApiClient;

  /// Fetches SpaceX company information.
  ///
  /// Throws [CompanyFetchingException] if fetching fails.
  Future<Company> fetchCompany() {
    try {
      return _spacexApiClient.fetchCompany();
    } on Exception {
      throw CompanyFetchingException();
    }
  }
}
