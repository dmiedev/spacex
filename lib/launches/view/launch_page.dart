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
        BlocProvider<LaunchFilteringBloc>(
          create: (context) => LaunchFilteringBloc(
            rocketRepository: context.read<RocketRepository>(),
            launchRepository: context.read<LaunchRepository>(),
          ),
        ),
        BlocProvider<LaunchBloc>(
          create: (context) => LaunchBloc(
            launchRepository: context.read<LaunchRepository>(),
          ),
        ),
      ],
      child: const _LaunchView(),
    );
  }
}

class _LaunchView extends StatefulWidget {
  const _LaunchView();

  @override
  State<_LaunchView> createState() => _LaunchViewState();
}

class _LaunchViewState extends State<_LaunchView> {
  final _searchBarController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Making sure BlocListeners are built before the event is sent so they
    // could react.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LaunchFilteringBloc>().add(const LaunchFilteringLoaded());
    });
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
                    previous.status == LaunchFilteringSaveLoadStatus.none &&
                    current.status != LaunchFilteringSaveLoadStatus.none,
                listener: (context, state) =>
                    _sendFirstLaunchPageRequest(context),
                child: BlocListener<LaunchFilteringBloc, LaunchFilteringState>(
                  listenWhen: (previous, current) =>
                      previous.status != current.status,
                  listener: _handleLaunchFilteringStatusChange,
                  child:
                      BlocListener<LaunchFilteringBloc, LaunchFilteringState>(
                    listenWhen: (previous, current) =>
                        previous.sorting != current.sorting ||
                        previous.filtering != current.filtering,
                    listener: (context, state) =>
                        _sendFirstLaunchPageRequest(context),
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
                onNextPageRequest: () => _sendNextPageRequest(context),
                onFirstPageErrorRetryButtonPressed: () =>
                    _sendNextPageRequest(context),
                onNextPageErrorRetryButtonPressed: () =>
                    _sendNextPageRequest(context),
              ),
            ],
          );
        },
      ),
    );
  }

  void _handleLaunchFilteringStatusChange(
    BuildContext context,
    LaunchFilteringState state,
  ) {
    final message = _getStatusSnackBarMessage(context, state.status);
    if (message == null) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  String? _getStatusSnackBarMessage(
    BuildContext context,
    LaunchFilteringSaveLoadStatus status,
  ) {
    final l10n = context.l10n;
    switch (status) {
      case LaunchFilteringSaveLoadStatus.saveFailure:
        return l10n.filterSaveFailureMessage;
      case LaunchFilteringSaveLoadStatus.saveSuccess:
        return l10n.filterSaveSuccessMessage;
      case LaunchFilteringSaveLoadStatus.loadFailure:
        return l10n.filterLoadFailureMessage;
      default:
        return null;
    }
  }

  void _sendFirstLaunchPageRequest(BuildContext context) {
    final filteringBloc = context.read<LaunchFilteringBloc>();
    final state = filteringBloc.state;
    // Making sure the search bar displays the correct content after the loading
    // of filtering options.
    _searchBarController.text = state.filtering.searchedPhrase;
    context.read<LaunchBloc>().add(
          LaunchPageRequested(
            pageNumber: 1,
            sorting: state.sorting,
            filtering: state.filtering,
          ),
        );
  }

  void _sendNextPageRequest(BuildContext context) {
    final filteringBlocState = context.read<LaunchFilteringBloc>().state;
    final launchBloc = context.read<LaunchBloc>();
    launchBloc.add(
      LaunchPageRequested(
        pageNumber: launchBloc.state.lastPageNumber + 1,
        sorting: filteringBlocState.sorting,
        filtering: filteringBlocState.filtering,
      ),
    );
  }

  void _handleSearchBarSubmit(BuildContext context, String text) {
    context.read<LaunchFilteringBloc>().add(
          LaunchFilteringSearchedTextSubmitted(searchedPhrase: text),
        );
  }

  @override
  void dispose() {
    _searchBarController.dispose();
    super.dispose();
  }
}
