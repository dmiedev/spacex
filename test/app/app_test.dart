import 'package:flutter_test/flutter_test.dart';
import 'package:launch_repository/launch_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rocket_repository/rocket_repository.dart';
import 'package:spacex/app/app.dart';

class MockLaunchRepository extends Mock implements LaunchRepository {}

class MockRocketRepository extends Mock implements RocketRepository {}

void main() {
  late LaunchRepository launchRepository;
  late RocketRepository rocketRepository;

  setUp(() {
    launchRepository = MockLaunchRepository();
    rocketRepository = MockRocketRepository();
  });

  group('App', () {
    test('App can be instantiated', () {
      expect(
        () => App(
          launchRepository: launchRepository,
          rocketRepository: rocketRepository,
        ),
        returnsNormally,
      );
    });
  });
}
