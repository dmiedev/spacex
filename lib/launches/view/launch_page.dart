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
  final _pagingController = PagingController<int, Launch>(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener(_handlePageRequest);
  }

  void _handlePageRequest(int pageNumber) {
    context.read<LaunchBloc>().add(LaunchPageRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text(
              'LAUNCHES',
              style: GoogleFonts.orbitron(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
              ),
            ),
          ],
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                title: const SearchBar(hintText: 'Search'),
                centerTitle: true,
                floating: true,
                snap: true,
                forceElevated: innerBoxIsScrolled,
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
                SliverPadding(
                  padding: const EdgeInsets.only(top: 10),
                  sliver: BlocListener<LaunchBloc, LaunchState>(
                    listener: _handleLaunchStateChange,
                    listenWhen: (previous, current) =>
                        previous.lastPageNumber != current.lastPageNumber,
                    child: PagedSliverList<int, Launch>(
                      pagingController: _pagingController,
                      builderDelegate: PagedChildBuilderDelegate<Launch>(
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
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _handleLaunchStateChange(BuildContext context, LaunchState state) {
    final reversedLaunches = state.launches.reversed.toList();
    _pagingController.appendPage(
      reversedLaunches.getRange(0, state.lastPageAmount).toList(),
      state.lastPageNumber + 1,
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
