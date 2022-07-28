import 'package:filter_repository/filter_repository.dart';
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

/// A page that displays a grid view of [LaunchCard]s with
/// [LaunchFilteringChips] and a [SearchBar] on top.
///
/// Creates instances of [LaunchBloc] and [LaunchFilteringBloc].
class LaunchPage extends StatelessWidget {
  /// Creates the launch app page.
  const LaunchPage({super.key});

  /// Returns a [MaterialPageRoute] that contains this page.
  static Route<LaunchPage> route() {
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
            filterRepository: context.read<FilterRepository>(),
          )..add(LaunchFilteringLoaded()),
        ),
      ],
      child: const _LaunchView(),
    );
  }
}

class _LaunchView extends StatelessWidget {
  const _LaunchView();

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
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              primary: false,
              automaticallyImplyLeading: false,
              toolbarHeight: 110,
              centerTitle: true,
              floating: true,
              snap: true,
              forceElevated: innerBoxIsScrolled,
              title: BlocListener<LaunchFilteringBloc, LaunchFilteringState>(
                listenWhen: (previous, current) =>
                    previous.allRockets == current.allRockets &&
                    previous != current,
                listener: _handleLaunchFilteringStateChange,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SearchBar(
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
                onNextPageRequest: () => _sendNextLaunchPageRequest(context),
                onFirstPageErrorRetryButtonPressed: () =>
                    _sendNextLaunchPageRequest(context),
                onNextPageErrorRetryButtonPressed: () =>
                    _sendNextLaunchPageRequest(context),
              ),
            ],
          );
        },
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

  void _sendNextLaunchPageRequest(BuildContext context) {
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
}
