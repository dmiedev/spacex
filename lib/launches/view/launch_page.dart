import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:spacex/launches/bloc/bloc.dart';
import 'package:spacex/launches/widgets/widgets.dart';
import 'package:spacex_api/spacex_api.dart';

class LaunchPage extends StatelessWidget {
  const LaunchPage({super.key});

  static Route<LaunchPage> get route {
    return MaterialPageRoute(
      builder: (context) => const LaunchPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LaunchBloc(
        launchRepository: context.read<LaunchRepository>(),
      ),
      child: const LaunchView(),
    );
  }
}

class LaunchView extends StatefulWidget {
  const LaunchView({super.key});

  @override
  State<LaunchView> createState() => _LaunchViewState();
}

class _LaunchViewState extends State<LaunchView> {
  final _gridController = PagingController<int, Launch>(
    firstPageKey: 1,
    invisibleItemsThreshold: 1,
  );
  final _searchBarController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _gridController.addPageRequestListener(_handlePageRequest);
  }

  void _handlePageRequest(int pageNumber) {
    context.read<LaunchBloc>().add(
          LaunchPageRequested(
            searchedText: _searchBarController.text,
            firstPage: pageNumber == 1,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'LAUNCHES',
          style: GoogleFonts.orbitron(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                toolbarHeight: 110,
                centerTitle: true,
                floating: true,
                snap: true,
                forceElevated: innerBoxIsScrolled,
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SearchBar(
                      controller: _searchBarController,
                      hintText: 'Search',
                      onSubmitted: _handleSearchBarSubmit,
                      onClearButtonPressed: _handleSearchBarClearButtonPress,
                    ),
                    const SizedBox(
                      height: 50,
                      child: FilteringChips(),
                    ),
                  ],
                ),
              ),
            )
          ];
        },
        body: Builder(
          builder: (BuildContext context) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverOverlapInjector(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                ),
                BlocListener<LaunchBloc, LaunchState>(
                  listener: _handleLaunchStateChange,
                  child: LaunchGrid(controller: _gridController),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _handleLaunchStateChange(BuildContext context, LaunchState state) {
    if (state.errorOccurred) {
      _gridController.error = true;
    } else if (state.hasReachedEnd) {
      _gridController.appendLastPage([]);
    } else {
      final reversedLaunches = state.launches.reversed.toList();
      _gridController.appendPage(
        reversedLaunches.getRange(0, state.lastPageAmount).toList(),
        state.lastPageNumber + 1,
      );
    }
  }

  void _handleSearchBarSubmit(String text) {
    _gridController.refresh();
  }

  void _handleSearchBarClearButtonPress() {
    _searchBarController.clear();
    _gridController.refresh();
  }

  @override
  void dispose() {
    _gridController.dispose();
    _searchBarController.dispose();
    super.dispose();
  }
}
