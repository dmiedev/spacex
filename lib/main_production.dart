import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rocket_repository/rocket_repository.dart';
import 'package:spacex/app/app.dart';
import 'package:spacex/bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final launchRepository = LaunchRepository();
  final rocketRepository = RocketRepository();

  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  await bootstrap(
    builder: () => App(
      launchRepository: launchRepository,
      rocketRepository: rocketRepository,
    ),
    storage: storage,
  );
}
