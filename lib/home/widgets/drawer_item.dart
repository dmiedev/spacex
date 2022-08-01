import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex/home/bloc/bloc.dart';

/// A [ListTile] item in a [Drawer].
class DrawerItem extends StatelessWidget {
  /// Creates a [ListTile] item in a [Drawer].
  const DrawerItem({
    super.key,
    required this.icon,
    required this.title,
    required this.page,
    required this.currentPage,
  });

  /// The icon this item has.
  final IconData icon;

  /// The title this item has.
  final String title;

  /// The page this item relates to.
  final HomeStatePage page;

  /// The current page of the app.
  final HomeStatePage currentPage;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      selected: page == currentPage,
      onTap: () => _handleTap(context),
    );
  }

  void _handleTap(BuildContext context) {
    context.read<HomeBloc>().add(HomePageChanged(newPage: page));
    Navigator.pop(context);
  }
}
