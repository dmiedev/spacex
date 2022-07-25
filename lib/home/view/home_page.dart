import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex/home/bloc/bloc.dart';
import 'package:spacex/home/widgets/widgets.dart';
import 'package:spacex/l10n/l10n.dart';
import 'package:spacex_ui/spacex_ui.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: SpacexAppBar(
            title: _getPageTitle(context, state.page),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  child: Image(
                    image: AssetImage('assets/spacex_logo_white.png'),
                  ),
                ),
                ..._buildDrawerItems(context, state.page),
              ],
            ),
          ),
          body: const PageBuilder(),
        );
      },
    );
  }

  String _getPageTitle(BuildContext context, HomeStatePage page) {
    final l10n = context.l10n;
    switch (page) {
      case HomeStatePage.launches:
        return l10n.launchesAppBarTitle;
      case HomeStatePage.rockets:
        return 'ROCKETS';
    }
  }

  List<DrawerItem> _buildDrawerItems(BuildContext context, HomeStatePage page) {
    final l10n = context.l10n;
    return [
      DrawerItem(
        icon: Icons.rocket_launch,
        title: l10n.launchesAppBarTitle,
        page: HomeStatePage.launches,
        currentPage: page,
      ),
      DrawerItem(
        icon: Icons.rocket,
        title: 'ROCKETS',
        page: HomeStatePage.rockets,
        currentPage: page,
      ),
    ];
  }
}
