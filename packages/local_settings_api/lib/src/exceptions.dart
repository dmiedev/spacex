abstract class _SettingRepositoryException implements Exception {}

/// An exception that occurs while saving a setting.
class SettingSaveException extends _SettingRepositoryException {}

/// An exception that occurs while loafing a setting.
class SettingLoadException extends _SettingRepositoryException {}
