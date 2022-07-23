import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:rocket_repository/rocket_repository.dart';
import 'package:spacex/l10n/l10n.dart';
import 'package:spacex/launch_filtering/bloc/bloc.dart';
import 'package:spacex/launch_filtering/widgets/widgets.dart';
import 'package:spacex/launches/bloc/bloc.dart';
import 'package:spacex/launches/widgets/widgets.dart';
import 'package:spacex_ui/spacex_ui.dart';

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
      child: const _LaunchView(),
    );
  }
}

class _LaunchView extends StatefulWidget {
  const _LaunchView({super.key});

  @override
  State<_LaunchView> createState() => _LaunchViewState();
}

class _LaunchViewState extends State<_LaunchView> {
  final _searchBarController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _sendLaunchPageRequestedEvent(
      context: context,
      pageNumber: 1,
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
            rocketIds: state.rocketIds,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: SpacexAppBar(title: l10n.launchesAppBarTitle),
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
                        hintText: l10n.searchBarHintText,
                        onSubmitted: (text) =>
                            _handleSearchBarSubmit(context, text),
                      ),
                      const SizedBox(
                        height: 50,
                        child: LaunchFilteringChips(),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ];
        },
        body: Builder(
          builder: (context) {
            final primaryController = PrimaryScrollController.of(context)!;
            return CustomScrollView(
              slivers: <Widget>[
                SliverOverlapInjector(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                ),
                LaunchGrid(
                  controller: primaryController,
                  onNextPageRequest: _sendNextLaunchPageRequest,
                  onFirstPageErrorRetryButtonPressed:
                      _sendNextLaunchPageRequest,
                  onNextPageErrorRetryButtonPressed: _sendNextLaunchPageRequest,
                ),
              ],
            );
          },
        ),
      ),
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

  void _sendNextLaunchPageRequest() {
    _sendLaunchPageRequestedEvent(
      context: context,
      pageNumber: context.read<LaunchBloc>().state.lastPageNumber + 1,
      state: context.read<LaunchFilteringBloc>().state,
    );
  }

  void _handleSearchBarSubmit(BuildContext context, String text) {
    context.read<LaunchFilteringBloc>().add(
          LaunchFilteringSearchedTextSubmitted(searchedText: text),
        );
  }

  @override
  void dispose() {
    _searchBarController.dispose();
    super.dispose();
  }
}
