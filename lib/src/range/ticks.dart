import 'dart:math' as math;

/// Returns an [Iterable] of approximately `count + 1` uniformly-spaced,
/// nicely-rounded values between [start] and [stop] (inclusive).
/// Each value is a power of ten multiplied by 1, 2 or 5.
///
/// Ticks are inclusive in the sense that they may include the specified start
/// and stop values if (and only if) they are exact, nicely-rounded values
/// consistent with the inferred step. More formally, each returned tick t
/// satisfies start ≤ t and t ≤ stop.
Iterable<num> ticks(num start, num stop, num count) {
  final bool isReverse = stop < start;

  if (isReverse) {
    final temp = start;
    start = stop;
    stop = temp;
  }

  final num step = tickIncrement(start, stop, count);

  // If step is 0 or infinite, can't compute ticks
  if (step == 0 || step.isInfinite) return <num>[];

  if (step > 0) {
    // Positive step
    start = (start / step).ceil();
    stop = (stop / step).floor();
    final int len = (stop - start).ceil();
    final ticks = List<num>(len);
    for (int i = 0; i < len; i++) {
      ticks[i] = (start + i) * step;
    }

    return isReverse ? ticks.reversed : ticks;
  } else {
    // Negative step
    start = (start * step).floor();
    stop = (stop * step).ceil();
    final int len = (stop - start).ceil();
    final ticks = List<num>(len);
    for (int i = 0; i < len; i++) {
      ticks[i] = (start - i) / step;
    }

    return isReverse ? ticks.reversed : ticks;
  }
}

num tickIncrement(num start, num stop, int count) {
  final double step = (stop - start) / count;
  final int power = (math.log(step) / math.ln10).floor();
  final num exp = math.pow(10, power);
  final double error = step / exp;

  if (power >= 0) {
    if (error >= _e10)
      return 10 * exp;
    else if (error >= _e5)
      return 5 * exp;
    else if (error >= _e2)
      return 2 * exp;
    else
      return 1 * exp;
  } else {
    final num negExp = -math.pow(10, -power);
    if (error >= _e10)
      return negExp / 10;
    else if (error >= _e5)
      return negExp / 5;
    else if (error >= _e2)
      return negExp / 2;
    else
      return negExp;
  }
}

num tickStep(num start, num stop, num count) {
  final num step0 = (stop - start).abs() / math.max(0, count);
  num step1 = math.pow(10, (math.log(step0) / math.ln10).floor());
  final num error = step0 / step1;

  if (error >= _e10) step1 *= 10;
  if (error >= _e5) step1 *= 5;
  if (error >= _e2) step1 *= 2;

  return stop < start ? -step1 : step1;
}

final num _e10 = math.sqrt(50);
final num _e5 = math.sqrt(10);
final num _e2 = math.sqrt(2);
