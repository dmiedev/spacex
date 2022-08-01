// ignore_for_file: prefer_constructors_over_static_methods

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_settings_api/local_settings_api.dart';
import 'package:mocktail/mocktail.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockObject extends Equatable {
  const MockObject({this.field1, this.field2});

  final int? field1;
  final List<String>? field2;

  Map<String, dynamic> toJson() => {'field1': field1, 'field2': field2};

  static MockObject fromJson(Map<String, dynamic> json) {
    return MockObject(
      field1: json['field1'] as int?,
      field2: (json['field2'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );
  }

  @override
  List<Object?> get props => [field1, field2];
}

void main() {
  const object = MockObject(field1: 123, field2: ['123', '345']);

  group('LocalSettingsApi', () {
    late MockSharedPreferences sharedPreferences;
    late LocalSettingsApi localSettingsApi;

    setUp(() {
      sharedPreferences = MockSharedPreferences();
      localSettingsApi = LocalSettingsApi(sharedPreferences: sharedPreferences);
    });

    group('.saveSetting()', () {
      test('throws SettingSaveException when saving fails', () {
        when(() => sharedPreferences.setString(any(), any()))
            .thenThrow(Exception());
        expect(
          () => localSettingsApi.saveSetting(name: 'name', object: 'object'),
          throwsA(isA<SettingSaveException>()),
        );

        when(() => sharedPreferences.setString(any(), any()))
            .thenAnswer((_) async => false);
        expect(
          () => localSettingsApi.saveSetting(name: 'name', object: 'object'),
          throwsA(isA<SettingSaveException>()),
        );
      });

      test('makes correct request', () {
        when(
          () => sharedPreferences.setString(
            any(that: equals('name')),
            any(that: equals(jsonEncode(object))),
          ),
        ).thenAnswer((_) async => true);
        expect(
          () => localSettingsApi.saveSetting(name: 'name', object: object),
          returnsNormally,
        );
      });
    });

    group('.loadSetting()', () {
      test('throws SettingLoadException when saving fails', () {
        when(() => sharedPreferences.getString(any())).thenThrow(Exception());
        expect(
          () => localSettingsApi.loadSetting(
            name: 'name',
            fromJson: MockObject.fromJson,
          ),
          throwsA(isA<SettingLoadException>()),
        );
      });

      test('makes correct request', () {
        when(() => sharedPreferences.getString(any(that: equals('name'))))
            .thenReturn(jsonEncode(object));
        expect(
          localSettingsApi.loadSetting(
            name: 'name',
            fromJson: MockObject.fromJson,
          ),
          equals(object),
        );

        when(() => sharedPreferences.getString(any(that: equals('name'))))
            .thenReturn(null);
        expect(
          localSettingsApi.loadSetting(
            name: 'name',
            fromJson: MockObject.fromJson,
          ),
          null,
        );
      });
    });
  });
}
