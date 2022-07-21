import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:rocket_repository/rocket_repository.dart';
import 'package:spacex/l10n/l10n.dart';
import 'package:spacex/launches/view/launch_page.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.launchRepository,
    required this.rocketRepository,
  });

  final LaunchRepository launchRepository;
  final RocketRepository rocketRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: launchRepository),
        RepositoryProvider.value(value: rocketRepository),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpaceX',
      theme: _buildTheme(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const LaunchPage(),
      scrollBehavior: AppScrollBehavior(),
    );
  }

  ThemeData _buildTheme() {
    final base = ThemeData.dark();

    return ThemeData(
      primaryColor: Colors.black,
      textTheme: GoogleFonts.robotoCondensedTextTheme(base.textTheme),
      scaffoldBackgroundColor: Colors.black,
      colorScheme: const ColorScheme(
        background: Colors.black,
        onBackground: Colors.white,
        brightness: Brightness.dark,
        primary: Colors.black,
        onPrimary: Colors.white,
        secondary: Colors.white,
        onSecondary: Colors.black,
        surface: Colors.black,
        onSurface: Colors.white,
        error: Colors.red,
        onError: Colors.white,
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all(Colors.black),
        side: const BorderSide(color: Colors.white),
      ),
    );
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices {
    return {
      PointerDeviceKind.touch,
      PointerDeviceKind.mouse,
    };
  }
}
