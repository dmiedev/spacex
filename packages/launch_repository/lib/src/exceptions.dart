abstract class _LaunchRepositoryException implements Exception {
  const _LaunchRepositoryException();
}

/// An exception that occurs while fetching rocket launches.
class LaunchFetchingException extends _LaunchRepositoryException {}

/// An exception that occurs while loading or saving launch sorting option.
class LaunchSortingException extends _LaunchRepositoryException {}

/// An exception that occurs while loading or saving launch filtering options.
class LaunchFilteringException extends _LaunchRepositoryException {}
