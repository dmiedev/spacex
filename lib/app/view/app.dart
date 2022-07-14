import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spacex/l10n/l10n.dart';
import 'package:spacex/launches/view/launch_page.dart';

class App extends StatelessWidget {
  const App({super.key});

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
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      primaryColor: Colors.black,
      textTheme: _buildTextTheme(),
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
    );
  }

  TextTheme _buildTextTheme() {
    return GoogleFonts.robotoCondensedTextTheme(ThemeData.dark().textTheme);
  }
}
