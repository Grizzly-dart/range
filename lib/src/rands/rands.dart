import 'dart:math';

extension RandomExt on Random {
  Iterable<int> ints(int count, {int max = 1 << 32}) =>
      Iterable.generate(count, (_) => nextInt(max));

  Iterable<bool> bools(int count) =>
      Iterable.generate(count, (_) => nextBool());

  Iterable<double> doubles(int count) =>
      Iterable.generate(count, (_) => nextDouble());
}
