import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex/home/bloc/bloc.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.icon,
    required this.title,
    required this.page,
    required this.currentPage,
  });

  final IconData icon;
  final String title;
  final HomeStatePage page;
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
