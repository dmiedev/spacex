abstract class _FilterRepositoryException implements Exception {
  const _FilterRepositoryException();
}

/// An exception that occurs while saving or loading filters.
class FilterSaveLoadException extends _FilterRepositoryException {}

/// An exception that is thrown if repository has not been initialized before
/// usage.
class FilterRepositoryNotInitializedException
    extends _FilterRepositoryException {}
