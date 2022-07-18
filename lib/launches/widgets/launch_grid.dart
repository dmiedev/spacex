import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:spacex/launches/widgets/launch_card.dart';
import 'package:spacex_api/spacex_api.dart';

class LaunchGrid extends StatelessWidget {
  const LaunchGrid({
    super.key,
    required this.controller,
  });

  final PagingController<int, Launch> controller;

  @override
  Widget build(BuildContext context) {
    return PagedSliverGrid<int, Launch>(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 525,
        mainAxisExtent: 175,
      ),
      showNewPageErrorIndicatorAsGridChild: false,
      showNewPageProgressIndicatorAsGridChild: false,
      showNoMoreItemsIndicatorAsGridChild: false,
      pagingController: controller,
      builderDelegate: PagedChildBuilderDelegate<Launch>(
        newPageProgressIndicatorBuilder: (context) => const _LoadingIndicator(),
        firstPageProgressIndicatorBuilder: (context) =>
            const _LoadingIndicator(),
        noItemsFoundIndicatorBuilder: (context) =>
            const _NoItemsFoundIndicator(),
        firstPageErrorIndicatorBuilder: (context) => _FirstPageErrorIndicator(
          onRetryButtonPressed: _handleFirstPageErrorRetryButtonPress,
        ),
        newPageErrorIndicatorBuilder: (context) => _NewPageErrorIndicator(
          onRetryButtonPressed: _handleNewPageErrorRetryButtonPress,
        ),
        itemBuilder: (context, item, index) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: LaunchCard(
            name: item.name != null
                ? item.name!.toUpperCase()
                : 'Unnamed launch'.toUpperCase(),
            number: item.flightNumber,
            date: item.dateUtc != null
                ? DateFormat.yMMMMd().format(item.dateUtc!).toUpperCase()
                : null,
            patchUrl: item.links?.patch?.small,
            onTap: () {},
          ),
        ),
      ),
    );
  }

  void _handleFirstPageErrorRetryButtonPress() {
    controller.refresh();
  }

  void _handleNewPageErrorRetryButtonPress() {
    controller.retryLastFailedRequest();
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator({super.key});

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
          const Text(
            'An error occurred while loading data.\n'
            'Please check your Internet connection.',
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
