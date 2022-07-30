import 'package:filter_repository/filter_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rocket_repository/rocket_repository.dart';
import 'package:spacex/app/app.dart';
import 'package:spacex/bootstrap.dart';

Future<void> main() async {
  await Hive.initFlutter();

  WidgetsFlutterBinding.ensureInitialized();

  final launchRepository = LaunchRepository();
  final rocketRepository = RocketRepository();
  final filterRepository = FilterRepository();

  await filterRepository.initialize();

  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  await bootstrap(
    builder: () => App(
      launchRepository: launchRepository,
      rocketRepository: rocketRepository,
      filterRepository: filterRepository,
    ),
    storage: storage,
  );
}
