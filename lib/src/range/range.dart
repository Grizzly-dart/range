library grizzly.range.range;

import 'dart:collection';

import 'package:quiver/core.dart';

export 'ticks.dart';

part 'constant_iterable.dart';
part 'double_range.dart';
part 'int_range.dart';
part 'month_range.dart';
part 'time_range.dart';

Iterable<T> range<T>(T start, T stop, [step]) {
  if (start is int && stop is int) {
    return IntRange(start, stop, step?.toInt() ?? 1) as Iterable<T>;
  } else if (start is num && stop is num) {
    return DoubleRange(
            start.toDouble(), stop.toDouble(), step?.toDouble() ?? 1.0)
        as Iterable<T>;
  } else if (T == DateTime) {
    if (step is Duration) {
      return TimeRange(start as DateTime, stop as DateTime, step)
          as Iterable<T>;
    } else if (step is int) {
      return MonthRange(start as DateTime, stop as DateTime, step)
          as Iterable<T>;
    } else {
      throw UnsupportedError(
          'step must be int or Duration for time range. but found $T');
    }
  }

  throw UnsupportedError('range is not supported for $T');
}

Iterable<T> until<T>(T stop, [step]) {
  if (stop is int) {
    return IntRange.until(stop, step?.toInt() ?? 1) as Iterable<T>;
  } else if (stop is double) {
    return DoubleRange.until(stop, step?.toDouble() ?? 1.0) as Iterable<T>;
  }
  // TODO TimeRange
  // TODO DurationRange

  throw Exception('Unknown type $T');
}

Iterable<int> indices(int length) => IntRange(0, length - 1);

Iterable<T> linspace<T extends num>(T start, T stop, [int count = 100]) {
  if (start is int && stop is int) {
    return IntRange.linspace(start.toInt(), stop.toInt(), count) as Iterable<T>;
  } else {
    return DoubleRange.linspace(start.toDouble(), stop.toDouble(), count)
        as Iterable<T>;
  }
}

Iterable<int> zeros([int length = 10]) => ConstantIterable(0, length);

Iterable<int> ones([int length = 10]) => ConstantIterable(1, length);

Iterable<T> repeat<T>(T v, int count) => ConstantIterable(v, count);

extension ObjRangeExt<T> on T {
  Iterable<T> repeat(int count) => ConstantIterable(this, count);
}