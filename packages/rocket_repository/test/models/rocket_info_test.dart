// ignore_for_file: prefer_const_constructors

import 'package:rocket_repository/rocket_repository.dart';
import 'package:test/test.dart';

void main() {
  group('RocketInfo', () {
    final info = RocketInfo(id: 'id', name: 'name');

    test('supports value comparisons', () {
      expect(info, RocketInfo(id: 'id', name: 'name'));
    });
  });
}
