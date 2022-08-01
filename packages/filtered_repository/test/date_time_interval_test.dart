import 'package:filtered_repository/filtered_repository.dart';
import 'package:test/test.dart';

void main() {
  final interval = DateTimeInterval(
    from: DateTime(2017, 3, 2),
    to: DateTime(2018, 3, 31),
  );

  final json = {
    'from': DateTime(2017, 3, 2).toIso8601String(),
    'to': DateTime(2018, 3, 31).toIso8601String(),
  };

  group('DateTimeInterval', () {
    test('supports value comparisons', () {
      expect(
        interval,
        DateTimeInterval(
          from: DateTime(2017, 3, 2),
          to: DateTime(2018, 3, 31),
        ),
      );
    });

    test('.toJson returns correct result', () {
      expect(interval.toJson(), json);
    });

    test('.fromJson returns correct result', () {
      expect(DateTimeInterval.fromJson(json), interval);
    });
  });
}
