import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex/home/bloc/bloc.dart';
import 'package:spacex/launches/launches.dart';
import 'package:spacex/rockets/rockets.dart';

/// Widget that builds a page according to the current [HomeState.page].
class PageBuilder extends StatelessWidget {
  /// Creates a widget that builds a page according to the current
  /// [HomeState.page].
  const PageBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        switch (state.page) {
          case HomeStatePage.launches:
            return const LaunchPage();
          case HomeStatePage.rockets:
            return const RocketPage();
        }
      },
    );
  }
}
