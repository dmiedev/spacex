abstract class _CompanyRepositoryException implements Exception {
  const _CompanyRepositoryException();
}

/// An exception that occurs while fetching company information.
class CompanyFetchingException extends _CompanyRepositoryException {}
