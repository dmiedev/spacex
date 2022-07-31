import 'package:flutter/material.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:rocket_repository/rocket_repository.dart';
import 'package:spacex/app/app.dart';
import 'package:spacex/bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final launchRepository = LaunchRepository();
  final rocketRepository = RocketRepository();

  await bootstrap(
    builder: () => App(
      launchRepository: launchRepository,
      rocketRepository: rocketRepository,
    ),
  );
}
