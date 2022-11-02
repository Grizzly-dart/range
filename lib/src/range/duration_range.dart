part of grizzly.range.range;

class DurationRange extends IterableBase<Duration> {
  /// Starting value of the range
  final Duration start;

  /// End value of the sequence
  final Duration stop;

  /// Spacing between values
  final Duration step;

  DurationRange._(this.start, this.stop, this.step);

  /// Returns an iterable of integers from [start] inclusive to [stop] inclusive
  /// with [step].
  ///
  ///     print(DurationRange(Duration(seconds: 10), Duration(seconds: 21), Duration(seconds: 2)));
  ///     => [0:00:10.000000, 0:00:12.000000, 0:00:14.000000, 0:00:16.000000, 0:00:18.000000, 0:00:20.000000]
  factory DurationRange(Duration start, Duration stop,
      [Duration step = const Duration(seconds: 1)]) {
    if (step == Duration()) {
      throw ArgumentError.value(step, 'step', 'cannot be 0');
    }

    if (stop < start) {
      if (!step.isNegative) {
        step = -step;
      }
    } else {
      if (step.isNegative) {
        step = -step;
      }
    }
    return DurationRange._(start, stop, step);
  }

  /// Returns an iterable of integers from 0 inclusive to [stop] inclusive with
  /// [step].
  ///
  ///     print(DurationRange.until(5, 2)); => (0, 2, 4)
  factory DurationRange.until(Duration stop,
          [Duration step = const Duration(seconds: 1)]) =>
      DurationRange(Duration(), stop, step);

  /// Returns an iterable of [count] integers from [start] inclusive to [stop]
  /// inclusive.
  ///
  ///     print(IntRange.linspace(1, 10, 5)); => (1, 3, 5, 7, 9)
  factory DurationRange.linspace(Duration start, Duration stop, int count) {
    if (count <= 0) {
      throw ArgumentError.value(count, 'count', 'Must be a positive integer');
    } else if (count == 1) {
      return DurationRange(start, start, stop - start);
    }

    Duration step;
    if (stop > start) {
      step = Duration(
          microseconds: ((stop - start).inMicroseconds) ~/ (count - 1));
    } else {
      step = Duration(
          microseconds: ((start - stop).inMicroseconds) ~/ (count - 1));
    }

    if (step == Duration()) step = Duration(microseconds: 1);
    if (stop < start) {
      step = -step;
    }

    return DurationRange(start, stop, step);
  }

  @override
  Iterator<Duration> get iterator => DurationRangeIterator(start, stop, step);

  @override
  int get length {
    if (!step.isNegative) {
      return ((stop.inMicroseconds - start.inMicroseconds + 1) /
              step.inMicroseconds)
          .ceil();
    } else {
      return ((start.inMicroseconds - stop.inMicroseconds + 1) /
              -step.inMicroseconds)
          .ceil();
    }
  }

  @override
  bool get isEmpty => length == 0;

  @override
  int get hashCode => hash3(start, stop, step);

  @override
  bool operator ==(other) =>
      other is DurationRange &&
      start == other.start &&
      stop == other.stop &&
      step == other.step;
}

class DurationRangeIterator implements Iterator<Duration> {
  Duration? _pos;
  final Duration _start;
  final Duration _stop;
  final Duration _step;

  DurationRangeIterator(Duration start, Duration stop, Duration step)
      : _start = start,
        _stop = stop,
        _step = step;

  @override
  Duration get current {
    if (_pos == null) {
      throw Exception('iterator not initialized');
    }

    return _pos!;
  }

  @override
  bool moveNext() {
    Duration next;
    if (_pos == null) {
      next = _start;
    } else {
      next = _pos! + _step;
    }

    if (_step > Duration()) {
      if (next > _stop) return false;
    } else {
      if (next < _stop) return false;
    }

    _pos = next;
    return true;
  }
}

extension DurationRangeExt on Duration {
  DurationRange to(Duration stop,
          [Duration step = const Duration(seconds: 1)]) =>
      DurationRange(this, stop, step);

  DurationRange take(int count, [Duration step = const Duration(seconds: 1)]) =>
      DurationRange(this, this + (step * count), step);

  DurationRange linspace(Duration stop, [int count = 50]) =>
      DurationRange.linspace(this, stop, count);
}
