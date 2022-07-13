abstract class _LaunchRepositoryException implements Exception {
  const _LaunchRepositoryException();
}

/// An exception that occurs while fetching rocket launches.
class LaunchFetchingException extends _LaunchRepositoryException {}
