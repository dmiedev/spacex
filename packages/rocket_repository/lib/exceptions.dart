abstract class _RocketRepositoryException implements Exception {
  const _RocketRepositoryException();
}

/// An exception that occurs while fetching rocket launches.
class RocketFetchingException extends _RocketRepositoryException {}
