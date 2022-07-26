abstract class _FilterRepositoryException implements Exception {
  const _FilterRepositoryException();
}

/// An exception that occurs while saving or loading filters.
class FilterSaveLoadException extends _FilterRepositoryException {}
