import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rocket_repository/rocket_repository.dart';
import 'package:spacex/rockets/bloc/bloc.dart';

class RocketPage extends StatelessWidget {
  const RocketPage({super.key});

  /// Returns a [MaterialPageRoute] that contains this page.
  static Route<RocketPage> route() {
    return MaterialPageRoute(
      builder: (context) => const RocketPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RocketBloc(
        rocketRepository: context.read<RocketRepository>(),
      )..add(RocketLoadRequested()),
      child: const _RocketView(),
    );
  }
}

class _RocketView extends StatelessWidget {
  const _RocketView();

  @override
  Widget build(BuildContext context) {
    return ListView();
  }
}
