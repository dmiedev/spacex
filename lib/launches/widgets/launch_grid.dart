import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:spacex/l10n/l10n.dart';
import 'package:spacex/launches/bloc/bloc.dart';
import 'package:spacex/launches/widgets/launch_card.dart';
import 'package:spacex_ui/spacex_ui.dart';

/// A [SliverGrid] of [LaunchCard]s that continuously requests launch pages from
/// the [LaunchBloc].
class LaunchGrid extends StatefulWidget {
  /// Creates a [SliverGrid] of [LaunchCard]s that continuously requests launch
  /// pages from the [LaunchBloc].
  const LaunchGrid({
    super.key,
    required this.controller,
    required this.onNextPageRequest,
    this.onFirstPageErrorRetryButtonPressed,
    this.onNextPageErrorRetryButtonPressed,
  });

  /// The controller of the [CustomScrollView] that this grid is contained
  /// within.
  final ScrollController controller;

  /// Called on a next launch page request.
  final void Function() onNextPageRequest;

  /// Called when the user presses the retry button below the first page error
  /// message.
  final void Function()? onFirstPageErrorRetryButtonPressed;

  /// Called when the user presses the retry button below the next page error
  /// message.
  final void Function()? onNextPageErrorRetryButtonPressed;

  @override
  State<LaunchGrid> createState() => _LaunchGridState();
}

class _LaunchGridState extends State<LaunchGrid> {
  static const _cardMaxWidth = 525.0;
  static const _cardHeight = 175.0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_handleScrollChange);
  }

  void _handleScrollChange() {
    final bloc = context.read<LaunchBloc>();
    final state = bloc.state;
    if (state.status != LaunchStateStatus.success || state.hasReachedEnd) {
      return;
    }
    final currentPosition = widget.controller.offset;
    final maxExtent = widget.controller.position.maxScrollExtent;
    if (currentPosition > maxExtent - _cardHeight * 1.5) {
      widget.onNextPageRequest();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaunchBloc, LaunchState>(
      buildWhen: (previous, current) =>
          previous.launches != current.launches ||
          previous.status != current.status,
      builder: (context, state) {
        if (state.launches.isEmpty) {
          switch (state.status) {
            case LaunchStateStatus.loading:
              return const SliverToBoxAdapter(child: _LoadingIndicator());
            case LaunchStateStatus.failure:
              return SliverToBoxAdapter(
                child: _FirstPageErrorIndicator(
                  onRetryButtonPressed:
                      widget.onFirstPageErrorRetryButtonPressed,
                ),
              );
            case LaunchStateStatus.success:
              return const SliverToBoxAdapter(child: _NoItemsFoundIndicator());
          }
        }
        return SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: _cardMaxWidth,
            mainAxisExtent: _cardHeight,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) => _buildGridItem(context, index, state),
            childCount: state.status == LaunchStateStatus.success
                ? state.launches.length
                : state.launches.length + 1,
          ),
        );
      },
    );
  }

  Widget _buildGridItem(BuildContext context, int index, LaunchState state) {
    if (index == state.launches.length) {
      switch (state.status) {
        case LaunchStateStatus.loading:
          return const _LoadingIndicator();
        case LaunchStateStatus.failure:
          return _NewPageErrorIndicator(
            onRetryButtonPressed: widget.onNextPageErrorRetryButtonPressed,
          );
        case LaunchStateStatus.success:
          return const SizedBox.shrink();
      }
    }
    final launch = state.launches[index];
    return LaunchCard(
      name: launch.name != null
          ? launch.name!.toUpperCase()
          : context.l10n.unnamedLaunchCardName.toUpperCase(),
      number: launch.flightNumber,
      date: launch.dateUtc != null
          ? DateFormat.yMMMMd().format(launch.dateUtc!).toUpperCase()
          : null,
      patchUrl: launch.links?.patch?.small,
      onTap: () {},
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}

class _NoItemsFoundIndicator extends StatelessWidget {
  const _NoItemsFoundIndicator();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return TextMessage(
      title: l10n.noLaunchesFoundMessageTitle,
      text: l10n.noLaunchesFoundMessageText,
    );
  }
}

class _FirstPageErrorIndicator extends StatelessWidget {
  const _FirstPageErrorIndicator({
    this.onRetryButtonPressed,
  });

  final void Function()? onRetryButtonPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return TextMessage(
      title: l10n.loadingErrorMessageTitle,
      text: l10n.loadingErrorMessageTextLong,
      button: IconTextButton(
        icon: const Icon(Icons.replay),
        label: 'RETRY',
        onPressed: onRetryButtonPressed,
      ),
    );
  }
}

class _NewPageErrorIndicator extends StatelessWidget {
  const _NewPageErrorIndicator({
    this.onRetryButtonPressed,
  });

  final void Function()? onRetryButtonPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return TextMessage(
      text: l10n.loadingErrorMessageTextShort,
      textMaxLines: 3,
      button: IconTextButton(
        icon: const Icon(Icons.replay),
        label: l10n.retryButtonLabel,
        onPressed: onRetryButtonPressed,
      ),
    );
  }
}
