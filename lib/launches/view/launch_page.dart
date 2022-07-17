import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
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

  final _chips = [
    ActionChip(
      avatar: const Icon(Icons.sort, size: 20),
      label: const Text('Sorting'),
      onPressed: () {},
    ),
    ActionChip(
      avatar: const Icon(
        Icons.history_toggle_off,
        size: 20,
        color: Colors.black,
      ), // Icons.schedule
      label: const Text('Upcoming', style: TextStyle(color: Colors.black)),
      onPressed: () {},
      backgroundColor: Colors.white,
    ),
    ActionChip(
      avatar: const Icon(Icons.rocket, size: 20),
      label: const Text('Rocket'),
      onPressed: () {},
    ),
    ActionChip(
      avatar: const Icon(Icons.date_range, size: 20),
      label: const Text('Year'),
      onPressed: () {},
    ),
    ActionChip(
      avatar: const Icon(Icons.tag, size: 20),
      label: const Text('Flight Number'),
      onPressed: () {},
    ),
    ActionChip(
      avatar: const Icon(Icons.done, size: 20),
      label: const Text('Successfulness'),
      onPressed: () {},
    ),
  ];

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
                toolbarHeight: 105,
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
                    SizedBox(
                      height: 50,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => _chips[index],
                        itemCount: _chips.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(width: 10);
                        },
                      ),
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
                  child: PagedSliverGrid<int, Launch>(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 525,
                      mainAxisExtent: 175,
                    ),
                    showNewPageErrorIndicatorAsGridChild: false,
                    showNewPageProgressIndicatorAsGridChild: false,
                    showNoMoreItemsIndicatorAsGridChild: false,
                    pagingController: _gridController,
                    builderDelegate: PagedChildBuilderDelegate<Launch>(
                      newPageProgressIndicatorBuilder: (context) {
                        return const _GridLoadingIndicator();
                      },
                      firstPageProgressIndicatorBuilder: (context) {
                        return const _GridLoadingIndicator();
                      },
                      noItemsFoundIndicatorBuilder: (context) {
                        return const _GridNoItemsFoundIndicator();
                      },
                      itemBuilder: (context, item, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: LaunchCard(
                          name: item.name != null
                              ? item.name!.toUpperCase()
                              : 'Unnamed launch'.toUpperCase(),
                          number: item.flightNumber,
                          date: item.dateUtc != null
                              ? DateFormat.yMMMMd()
                                  .format(item.dateUtc!)
                                  .toUpperCase()
                              : null,
                          patchUrl: item.links?.patch?.small,
                          onTap: () {},
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _handleLaunchStateChange(BuildContext context, LaunchState state) {
    if (state.hasReachedEnd) {
      _gridController.appendLastPage([]);
      return;
    }
    final reversedLaunches = state.launches.reversed.toList();
    _gridController.appendPage(
      reversedLaunches.getRange(0, state.lastPageAmount).toList(),
      state.lastPageNumber + 1,
    );
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
    super.dispose();
  }
}

class _GridLoadingIndicator extends StatelessWidget {
  const _GridLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          CircularProgressIndicator(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ],
      ),
    );
  }
}

class _GridNoItemsFoundIndicator extends StatelessWidget {
  const _GridNoItemsFoundIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: const [
          Text(
            'NO LAUNCHES FOUND',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            'Try changing your search criteria.',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
