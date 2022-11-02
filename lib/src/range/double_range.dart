part of grizzly.range.range;

class DoubleRange extends IterableBase<double> {
  /// Starting value of the range
  final double start;

  /// End value of the sequence
  final double stop;

  /// Spacing between values
  final double step;

  DoubleRange._(this.start, this.stop, this.step);

  /// Returns an iterable of integers from [start] inclusive to [stop] inclusive
  /// with [step].
  ///
  /// Examples:
  ///   print(DoubleRange(0, 5)); // (0.0, 1.0, 2.0, 3.0, 4.0, 5.0)
  ///   print(DoubleRange(0, 5, 0.5)); // (0.0, 0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0)
  ///   print(DoubleRange(5, -5)); // (5.0, 4.0, 3.0, 2.0, 1.0, 0.0, -1.0, -2.0, -3.0, -4.0, -5.0)
  factory DoubleRange(double start, double stop, [double step = 1]) {
    if (step == 0) {
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
    return DoubleRange._(start, stop, step);
  }

  /// Create a range [0, stop] with [step]
  ///
  ///   IntRange.until(5, 2); // (0.0, 2.0, 4.0)
  ///   IntRange.until(-5, -2); // (0.0, -2.0, -4.0)
  factory DoubleRange.until(double stop, [double step = 1.0]) =>
      DoubleRange(0.0, stop, step);

  /// Returns an iterable of [count] integers from [start] inclusive to [stop]
  /// inclusive.
  ///
  ///   DoubleRange.linspace(-4.5, 20.5, 5); // [-4.5, 1.75, 8.0, 14.25, 20.5]
  ///   DoubleRange.linspace(10, -8, 5); // [10.0, 5.5, 1.0, -3.5, -8.0]
  ///   DoubleRange.linspace(0, 1, 5); // [0.0, 0.25, 0.5, 0.75, 1.0]
  ///   DoubleRange.linspace(0, 1, 6); // [0.0, 0.2, 0.4, 0.6, 0.8, 1.0]
  factory DoubleRange.linspace(double start, double stop, [int count = 50]) {
    if (count <= 0) {
      throw ArgumentError.value(count, 'count', 'Must be a positive integer');
    } else if(count == 0) {
      return DoubleRange(start, stop, stop - start);
    }

    double step = 0;
    if (stop > start) {
      step = (stop - start) / (count - 1);
    } else {
      step = (start - stop) / (count - 1);
    }

    if (step == 0) step = 1;
    if (stop < start) {
      step = -step;
    }

    return DoubleRange(start, stop, step);
  }

  @override
  Iterator<double> get iterator => DoubleRangeIterator(start, stop, step);

  @override
  int get length {
    if (!step.isNegative) {
      int ret = ((stop - start + 1e-12) / step).ceil();
      return ret;
    } else {
      int ret = ((start - stop + 1e-12) / -step).ceil();
      return ret;
    }
  }

  @override
  bool get isEmpty => length == 0;

  @override
  int get hashCode => hash3(start, stop, step);

  @override
  bool operator ==(other) =>
      other is DoubleRange &&
      start == other.start &&
      stop == other.stop &&
      step == other.step;
}

class DoubleRangeIterator implements Iterator<double> {
  double? _pos;
  final double _start;
  final double _stop;
  final double _step;

  DoubleRangeIterator(double start, double stop, double step)
      : _start = start,
        _stop = stop,
        _step = step;

  @override
  double get current {
    if (_pos == null) {
      throw Exception('iterator not initialized');
    }
    return _pos!;
  }

  @override
  bool moveNext() {
    double next;
    if (_pos == null) {
      next = _start;
    } else {
      next = _pos! + _step;
    }

    if (_step > 0) {
      if (next > (_stop + 1e-12)) return false;
    } else {
      if (next < (_stop - 1e-12)) return false;
    }

    _pos = next;
    return true;
  }
}

extension DoubleRangeExt on double {
  DoubleRange to(double stop, [double step = 1]) =>
      DoubleRange(this, stop, step);

  DoubleRange take(int count, [double step = 1]) =>
      DoubleRange(this, this + (count * step), step);

  DoubleRange linspace(double stop, [int count = 50]) =>
      DoubleRange.linspace(this, stop, count);
}
