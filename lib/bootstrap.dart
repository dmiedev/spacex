import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap({
  required FutureOr<Widget> Function() builder,
  required HydratedStorage storage,
}) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  await runZonedGuarded(
    () async {
      await HydratedBlocOverrides.runZoned(
        () => BlocOverrides.runZoned(
          () async => runApp(await builder()),
          blocObserver: AppBlocObserver(),
        ),
        storage: storage,
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
