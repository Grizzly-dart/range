import 'dart:math';

import 'package:mt19937/mt19937.dart';

extension RandomExt on Random {
  Iterable<int> ints(int count, {int max = 1 << 32}) =>
      Iterable.generate(count, (_) => nextInt(max));

  Iterable<bool> bools(int count) =>
      Iterable.generate(count, (_) => nextBool());

  Iterable<double> doubles(int count) =>
      Iterable.generate(count, (_) => nextDouble());
}

/// Makes testing across C, Python and Dart easier when all of them generate the
/// same random numbers
class MTRandom implements Random {
  final MersenneTwister mt;

  MTRandom({int seed = 0}) : mt = MersenneTwister(seed: seed);

  @override
  bool nextBool() => mt.genRandInt32() > 0x7FFFFFFF;

  @override
  double nextDouble() => mt.genRandInt32() / 0xFFFFFFFF;

  @override
  int nextInt(int max) => mt.genRandInt32() % max;
}