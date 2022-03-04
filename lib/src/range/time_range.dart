part of grizzly.range.range;

class TimeRange extends IterableBase<DateTime> {
  /// Starting value of the range
  final DateTime start;

  /// End value of the sequence
  final DateTime stop;

  /// Spacing between values
  final Duration step;

  TimeRange._(this.start, this.stop, this.step);

  /// Returns an iterable of integers from [start] inclusive to [stop] inclusive
  /// with [step].
  ///
  ///     TimeRange(DateTime(2019, 1, 1), DateTime(2019, 1, 20), Duration(days: 1))
  factory TimeRange(DateTime start, DateTime stop, Duration step) {
    if (step.isNegative) {
      throw ArgumentError.value(step, 'step', 'Must be greater than 0');
    }
    if (stop.isBefore(start)) step = -step;
    return TimeRange._(start, stop, step);
  }

  factory TimeRange.us(DateTime start, DateTime stop, [int step = 1]) {
    if (step <= 0) {
      throw ArgumentError.value(step, 'step', 'Must be greater than 0');
    }

    return TimeRange(start, stop, Duration(microseconds: step));
  }

  factory TimeRange.ms(DateTime start, DateTime stop, [int step = 1]) {
    if (step <= 0) {
      throw ArgumentError.value(step, 'step', 'Must be greater than 0');
    }

    return TimeRange(start, stop, Duration(milliseconds: step));
  }

  factory TimeRange.s(DateTime start, DateTime stop, [int step = 1]) {
    if (step <= 0) {
      throw ArgumentError.value(step, 'step', 'Must be greater than 0');
    }

    return TimeRange(start, stop, Duration(seconds: step));
  }

  factory TimeRange.m(DateTime start, DateTime stop, [int step = 1]) {
    if (step <= 0) {
      throw ArgumentError.value(step, 'step', 'Must be greater than 0');
    }

    return TimeRange(start, stop, Duration(minutes: step));
  }

  factory TimeRange.h(DateTime start, DateTime stop, [int step = 1]) {
    if (step <= 0) {
      throw ArgumentError.value(step, 'step', 'Must be greater than 0');
    }

    return TimeRange(start, stop, Duration(hours: step));
  }

  factory TimeRange.d(DateTime start, DateTime stop, [int step = 1]) {
    if (step <= 0) {
      throw ArgumentError.value(step, 'step', 'Must be greater than 0');
    }

    return TimeRange(start, stop, Duration(days: step));
  }

  factory TimeRange.w(DateTime start, DateTime stop, [int step = 1]) {
    if (step <= 0) {
      throw ArgumentError.value(step, 'step', 'Must be greater than 0');
    }

    return TimeRange(start, stop, Duration(days: step * 7));
  }

  @override
  Iterator<DateTime> get iterator => TimeRangeIterator(start, stop, step);

  @override
  int get length {
    if (step.inMicroseconds == 0) throw Exception('Step cannot be 0');
    if (!step.isNegative) {
      if (start.isAfter(stop)) {
        throw Exception('start cannot be after stop when step is positive!');
      }
      int ret =
          (stop.difference(start).inMicroseconds / step.inMicroseconds).ceil();
      final last = start.add(step * ret);
      if (last.isBefore(stop) || last.isAtSameMomentAs(stop)) ret++;
      return ret;
    } else {
      if (start.isBefore(stop)) {
        throw Exception('start cannot be before stop when step is negative!');
      }
      int ret =
          (start.difference(stop).inMicroseconds / -step.inMicroseconds).ceil();
      final last = start.add(step * ret);
      if (last.isAfter(stop) || last.isAtSameMomentAs(stop)) ret++;
      return ret;
    }
  }

  @override
  bool get isEmpty => length == 0;

  @override
  int get hashCode => hash3(start, stop, step);

  @override
  bool operator ==(other) =>
      other is TimeRange &&
      start == other.start &&
      stop == other.stop &&
      step == other.step;
}

class TimeRangeIterator implements Iterator<DateTime> {
  DateTime? _pos;
  final DateTime _start;
  final DateTime _stop;
  final Duration _step;

  TimeRangeIterator(DateTime start, DateTime stop, Duration step)
      : _start = start,
        _stop = stop,
        _step = step;

  @override
  DateTime get current {
    if (_pos == null) {
      throw Exception('iterator not initialized');
    }

    return _pos!;
  }

  @override
  bool moveNext() {
    DateTime next;
    if (_pos == null) {
      next = _start;
    } else {
      next = _pos!.add(_step);
    }

    if (!_step.isNegative) {
      if (next.isAfter(_stop)) return false;
    } else {
      if (next.isBefore(_stop)) return false;
    }

    _pos = next;
    return true;
  }
}

extension TimeRangeExt on DateTime {
  TimeRange to(DateTime stop, [Duration step = const Duration(days: 1)]) =>
      TimeRange(this, stop, step);
}

/*
abstract class CalendarRange extends Iterable<DateTime> {
  const CalendarRange();

  DateTime step(DateTime date, num steps);

  DateTime floor(DateTime date);

  DateTime ceil(DateTime date) => step(floor(date), 1);

  DateTime round(DateTime date) {
    final DateTime d0 = floor(date);
    final DateTime d1 = step(d0, 1);

    if (date.difference(d0) < d1.difference(date)) {
      return d0;
    } else {
      return d1;
    }
  }

  List<DateTime> range(DateTime start, DateTime stop, [int skip = 0]) {
    final values = <DateTime>[];

    DateTime time = start;
    if (skip > 0) {
      while (time.isBefore(stop)) {
        values.add(time);
        time = step(time, skip);
      }
    } else {
      while (time.isBefore(stop)) {
        values.add(time);
        time = step(time, 1);
      }
    }

    return values;
  }
}
 */
