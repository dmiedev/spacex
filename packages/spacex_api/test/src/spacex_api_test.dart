// ignore_for_file: prefer_const_constructors
import 'package:spacex_api/spacex_api.dart';
import 'package:test/test.dart';

void main() {
  group('SpacexApi', () {
    test('can be instantiated', () {
      expect(SpacexApiClient(), isNotNull);
    });
  });
}
