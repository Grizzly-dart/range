import 'package:grizzly_range/grizzly_range.dart';
import 'package:test/test.dart';

void main() {
  group('IntRanger.default', () {
    test('Forward', () {
      final ranger = IntRange(0, 100, 10);
      expect(ranger, List.generate(11, (i) => i * 10));
    });

    test('Reverse', () {
      var ranger = IntRange(100, 0, 10);
      expect(ranger, List.generate(11, (i) => i * 10).reversed);

      ranger = IntRange(100, 0, -10);
      expect(ranger, List.generate(11, (i) => i * 10).reversed);
    });
  });

  group('IntRanger.until', () {
    test('Forward.Complete', () {
      final ranger = IntRange.until(6, 2);
      expect(ranger, List.generate(4, (i) => i * 2));
    });
    test('Forward.Incomplete', () {
      final ranger = IntRange.until(5, 2);
      expect(ranger, List.generate(3, (i) => i * 2));
    });
    test('Reverse.Complete', () {
      final ranger = IntRange.until(-6, 2);
      expect(ranger, List.generate(4, (i) => i * -2));
    });
    test('Reverse.Incomplete', () {
      final ranger = IntRange.until(-5, 2);
      expect(ranger, List.generate(3, (i) => i * -2));
    });
  });

  group('IntRanger.linspace', () {
    test('Forward.Complete', () {
      Iterable<int> ranger;
      ranger = IntRange.linspace(0, 8, 5);
      print(ranger);
      expect(ranger, List.generate(5, (i) => i * 2));

      ranger = IntRange.linspace(-10, -2, 5);
      print(ranger);
      expect(ranger, List.generate(5, (i) => -10 + (i * 2)));

      ranger = IntRange.linspace(-10, 10, 11);
      print(ranger);
      expect(ranger, List.generate(11, (i) => -10 + (i * 2)));

      ranger = IntRange.linspace(-100, 100, 5);
      print(ranger);
      expect(ranger, List.generate(5, (i) => -100 + (i * 50)));
    });

    test('Forward.Incomplete', () {
      Iterable<int> ranger;
      ranger = IntRange.linspace(0, 9, 5);
      print(ranger);
      expect(ranger, List.generate(5, (i) => i * 2));

      ranger = IntRange.linspace(-10, -1, 5);
      print(ranger);
      expect(ranger, List.generate(5, (i) => -10 + (i * 2)));

      ranger = IntRange.linspace(-10, 11, 11);
      print(ranger);
      expect(ranger, List.generate(11, (i) => -10 + (i * 2)));

      ranger = IntRange.linspace(-100, 103, 5);
      print(ranger);
      expect(ranger, List.generate(5, (i) => -100 + (i * 50)));
    });

    test('Reverse.Complete', () {
      Iterable<int> ranger;
      ranger = IntRange.linspace(0, -8, 5);
      print(ranger);
      expect(ranger, List.generate(5, (i) => 0 - (i * 2)));

      ranger = IntRange.linspace(-2, -10, 5);
      print(ranger);
      expect(ranger, List.generate(5, (i) => -2 - (i * 2)));

      ranger = IntRange.linspace(10, -10, 11);
      print(ranger);
      expect(ranger, List.generate(11, (i) => 10 - (i * 2)));

      ranger = IntRange.linspace(100, -100, 5);
      print(ranger);
      expect(ranger, List.generate(5, (i) => 100 - (i * 50)));
    });

    test('Reverse.Incomplete', () {
      Iterable<int> ranger;
      ranger = IntRange.linspace(8, -1, 5);
      print(ranger);
      expect(ranger, List.generate(5, (i) => 8 - (i * 2)));

      ranger = IntRange.linspace(-1, -11, 5);
      print(ranger);
      expect(ranger, List.generate(5, (i) => -1 - (i * 2)));

      ranger = IntRange.linspace(10, -11, 11);
      print(ranger);
      expect(ranger, List.generate(11, (i) => 10 - (i * 2)));

      ranger = IntRange.linspace(100, -103, 5);
      print(ranger);
      expect(ranger, List.generate(5, (i) => 100 - (i * 50)));
    });
  });
}
