import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex/launch_details/bloc/bloc.dart';
import 'package:spacex_api/spacex_api.dart';
import 'package:spacex_ui/spacex_ui.dart';

class LaunchDetailsPage extends StatelessWidget {
  const LaunchDetailsPage({
    super.key,
    required this.launch,
  });

  final Launch launch;

  static Route<LaunchDetailsPage> route({required Launch launch}) {
    return MaterialPageRoute(
      builder: (context) => LaunchDetailsPage(
        launch: launch,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LaunchDetailsBloc(
        launch: launch,
      ),
      child: const _LaunchDetailsView(),
    );
  }
}

class _LaunchDetailsView extends StatelessWidget {
  const _LaunchDetailsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SpacexAppBar(title: 'LAUNCH DETAILS'),
      body: ListView(),
    );
  }
}
