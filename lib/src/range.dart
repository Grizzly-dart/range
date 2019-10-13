library grizzly.viz.scales.ranger;

import 'dart:math' as math;
import 'dart:collection';

import 'package:quiver_hashcode/hashcode.dart';

export 'ticks.dart';

part 'constant_iterable.dart';
part 'double_range.dart';
part 'int_range.dart';
part 'month_range.dart';
part 'time_range.dart';

Iterable<T> range<T>(T start, T stop, [step]) {
  if (start is int) {
    return IntRange(start, stop as int, step?.toInt() ?? 1) as Iterable<T>;
  } else if (start is double) {
    return DoubleRange(start, stop as double, step?.toDouble() ?? 1.0)
        as Iterable<T>;
  } else if (start is DateTime) {
    return TimeRange(start, stop as DateTime, step as Duration) as Iterable<T>;
  }

  throw Exception('Unknown type $T');
}

Iterable<T> until<T>(T stop, [step]) {
  if (stop is int) {
    return IntRange.until(stop, step?.toInt() ?? 1) as Iterable<T>;
  } else if (stop is double) {
    return DoubleRange.until(stop, step?.toDouble() ?? 1.0) as Iterable<T>;
  }

  throw Exception('Unknown type $T');
}

Iterable<int> indices(int length) => IntRange(0, length - 1);

Iterable<T> linspace<T extends num>(T start, T stop, [int count = 100]) {
  if (start is int) {
    return IntRange.linspace(start, stop.toInt(), count) as Iterable<T>;
  } else if (start is double) {
    return DoubleRange.linspace(start, stop.toDouble(), count) as Iterable<T>;
  }

  throw Exception('Unknown type T');
}

Iterable<int> zeros([int length = 10]) => ConstantIterable(0, length);

Iterable<int> ones([int length = 10]) => ConstantIterable(1, length);
