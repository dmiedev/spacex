import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:spacex/launches/bloc/bloc.dart';
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
  final _pagingController = PagingController(firstPageKey: 1);

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
        title: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Image.asset(
            'assets/spacex_logo_white.png',
            width: 150,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          PagedSliverList(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Launch>(
              itemBuilder: (context, item, index) => Card(
                child: Text(item.name ?? 'Unknown name'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
