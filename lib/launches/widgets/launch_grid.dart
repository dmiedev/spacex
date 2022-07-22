import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:spacex/launches/bloc/bloc.dart';
import 'package:spacex/launches/widgets/launch_card.dart';

class LaunchGrid extends StatefulWidget {
  const LaunchGrid({
    super.key,
    required this.controller,
    required this.onNextPageRequest,
    this.onFirstPageErrorRetryButtonPressed,
    this.onNextPageErrorRetryButtonPressed,
  });

  final ScrollController controller;
  final void Function() onNextPageRequest;
  final void Function()? onFirstPageErrorRetryButtonPressed;
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
            (context, index) => _gridItemBuilder(context, index, state),
            childCount: state.status == LaunchStateStatus.success
                ? state.launches.length
                : state.launches.length + 1,
          ),
        );
      },
    );
  }

  Widget _gridItemBuilder(BuildContext context, int index, LaunchState state) {
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
          : 'Unnamed launch'.toUpperCase(),
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
  const _LoadingIndicator({super.key});

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
  const _NoItemsFoundIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: const [
          Text(
            'NO LAUNCHES FOUND',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            'Please try changing your search criteria.',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _FirstPageErrorIndicator extends StatelessWidget {
  const _FirstPageErrorIndicator({
    super.key,
    this.onRetryButtonPressed,
  });

  final void Function()? onRetryButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          const Text(
            'AN ERROR OCCURRED',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const Text(
            'Please check your Internet connection. If it is alright, it may '
            'be a problem on our end.\n\n'
            'You can also try reloading the page or changing your search '
            'criteria.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onRetryButtonPressed,
            style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith(
                (states) => Colors.white,
              ),
              foregroundColor: MaterialStateColor.resolveWith(
                (states) => Colors.black,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.replay),
                SizedBox(width: 5),
                Text('RETRY'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NewPageErrorIndicator extends StatelessWidget {
  const _NewPageErrorIndicator({
    super.key,
    this.onRetryButtonPressed,
  });

  final void Function()? onRetryButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          const AutoSizeText(
            'An error occurred while loading data.\n'
            'Please check your Internet connection.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
            maxLines: 3,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onRetryButtonPressed,
            style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith(
                (states) => Colors.white,
              ),
              foregroundColor: MaterialStateColor.resolveWith(
                (states) => Colors.black,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.replay),
                SizedBox(width: 5),
                Text('RETRY'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
