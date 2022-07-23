import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// The [AppBar] that is used in the SpaceX app.
class SpacexAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// The [AppBar] that is used in the SpaceX app.
  const SpacexAppBar({
    super.key,
    required this.title,
  });

  /// The title string this app bar displays.
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: GoogleFonts.orbitron(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 3,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
