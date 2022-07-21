import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:rocket_repository/rocket_repository.dart';
import 'package:spacex/launch_filtering/bloc/bloc.dart';
import 'package:spacex/launch_filtering/widgets/widgets.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<LaunchBloc>(
          create: (context) => LaunchBloc(
            launchRepository: context.read<LaunchRepository>(),
          ),
        ),
        BlocProvider<LaunchFilteringBloc>(
          create: (context) => LaunchFilteringBloc(
            rocketRepository: context.read<RocketRepository>(),
          ),
        ),
      ],
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
    _sendLaunchPageRequestedEvent(
      context: context,
      pageNumber: pageNumber,
      state: context.read<LaunchFilteringBloc>().state,
    );
  }

  void _sendLaunchPageRequestedEvent({
    required BuildContext context,
    required int pageNumber,
    required LaunchFilteringState state,
  }) {
    context.read<LaunchBloc>().add(
          LaunchPageRequested(
            pageNumber: pageNumber,
            searchedText: state.searchedText,
            sorting: state.sorting,
            time: state.time,
            dateInterval: state.dateInterval,
            flightNumber: state.flightNumber,
            successfulness: state.successfulness,
            rocketIds: state.allRockets != null
                ? state.rockets
                    .map((index) => state.allRockets![index].id)
                    .toList()
                : null,
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
                title: BlocListener<LaunchFilteringBloc, LaunchFilteringState>(
                  listenWhen: (previous, current) =>
                      previous.allRockets == current.allRockets,
                  listener: _handleLaunchFilteringStateChange,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SearchBar(
                        controller: _searchBarController,
                        hintText: 'Search',
                        onSubmitted: (text) =>
                            _handleSearchBarSubmit(context, text),
                      ),
                      const SizedBox(
                        height: 50,
                        child: FilteringChips(),
                      ),
                    ],
                  ),
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
    _gridController.value = PagingState(
      nextPageKey: state.hasReachedEnd ? null : state.lastPageNumber + 1,
      itemList: state.launches,
      error: state.errorOccurred ? true : null,
    );
  }

  void _handleLaunchFilteringStateChange(
    BuildContext context,
    LaunchFilteringState state,
  ) {
    _sendLaunchPageRequestedEvent(
      context: context,
      pageNumber: 1,
      state: state,
    );
  }

  void _handleSearchBarSubmit(BuildContext context, String text) {
    context.read<LaunchFilteringBloc>().add(
          LaunchFilteringSearchedTextSubmitted(searchedText: text),
        );
  }

  @override
  void dispose() {
    _gridController.dispose();
    _searchBarController.dispose();
    super.dispose();
  }
}
