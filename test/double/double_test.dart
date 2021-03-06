import 'package:grizzly_range/grizzly_range.dart';
import 'package:test/test.dart';

void main() {
  group('Ranger.Double', () {
    setUp(() {});

    test('forward', () {
      final ranger = DoubleRange(0.0, 100.0, 10.0);
      expect(ranger, List.generate(11, (i) => i * 10));
    });

    test('reverse', () {
      final ranger = DoubleRange(100.0, 0.0, 10.0);
      expect(ranger, List.generate(11, (i) => i * 10).reversed);
    });

    test('until', () {
      final ranger = DoubleRange.until(10.0, 2.0);
      expect(ranger, List.generate(6, (i) => i * 2));
    });

    test('until.neg stop', () {
      final ranger = DoubleRange.until(-10.0, 2.0);
      expect(ranger, List.generate(6, (i) => -i * 2));
    });

    test('linspace.normal', () {
      final ranger = DoubleRange.linspace(0.0, 100.0, 10);
      expect(ranger,
          [0.0, 10.0, 20.0, 30.0, 40.0, 50.0, 60.0, 70.0, 80.0, 90.0, 100.0]);
    });

    test('linspace.unit_space', () {
      final ranger = DoubleRange.linspace(0.0, 1.0, 10);
      expect(ranger, [
        0.0,
        0.1,
        0.2,
        0.30000000000000004,
        0.4,
        0.5,
        0.6,
        0.7,
        0.7999999999999999,
        0.8999999999999999,
        0.9999999999999999
      ]);
    });
  });
}
