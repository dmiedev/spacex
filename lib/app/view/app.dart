import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:rocket_repository/rocket_repository.dart';
import 'package:spacex/home/home.dart';
import 'package:spacex/l10n/l10n.dart';
import 'package:spacex_ui/spacex_ui.dart';

/// The SpaceX app.
class App extends StatelessWidget {
  /// Creates the SpaceX app.
  const App({
    super.key,
    required this.launchRepository,
    required this.rocketRepository,
  });

  /// Launch repository for this app to use.
  final LaunchRepository launchRepository;

  /// Rocket repository for this app to use.
  final RocketRepository rocketRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: launchRepository),
        RepositoryProvider.value(value: rocketRepository),
      ],
      child: const _AppView(),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpaceX',
      theme: SpacexAppTheme.theme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomePage(),
      scrollBehavior: _AppScrollBehavior(),
    );
  }
}

class _AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices {
    return {
      PointerDeviceKind.touch,
      PointerDeviceKind.mouse,
    };
  }
}
