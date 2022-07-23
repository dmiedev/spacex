import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// An extension on [BuildContext] that simplifies obtaining an
/// [AppLocalizations] instance.
extension AppLocalizationsX on BuildContext {
  /// The closest [AppLocalizations] instance that encloses this context.
  AppLocalizations get l10n => AppLocalizations.of(this);
}
