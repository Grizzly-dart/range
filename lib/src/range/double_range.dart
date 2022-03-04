part of grizzly.range.range;

class DoubleRange extends IterableBase<double> {
  /// Starting value of the range
  final double start;

  /// End value of the sequence
  final double stop;

  /// Spacing between values
  final double step;

  DoubleRange._(this.start, this.stop, this.step);

  factory DoubleRange(double start, double stop, [double step = 1]) {
    if (step <= 0) {
      throw ArgumentError.value(step, 'step', 'Must be greater than 0');
    }

    if (stop < start) step = -step;
    return DoubleRange._(start, stop, step);
  }

  /// Create a range [0, stop] with [step]
  factory DoubleRange.until(double stop, [double step = 1.0]) {
    if (step <= 0) {
      throw ArgumentError.value(step, 'step', 'Must be greater than 0');
    }

    if (stop < 0) step = -step;
    return DoubleRange._(0.0, stop, step);
  }

  factory DoubleRange.linspace(double start, double stop, [int count = 50]) {
    if (count <= 0) {
      throw ArgumentError.value(count, 'count', 'Must be a positive integer');
    }

    double step = 0;
    if (stop > start) {
      step = (stop - start /* TODO  + 1*/) / count;
    } else {
      step = (start - stop /* TODO + 1*/) / count;
    }

    if (step == 0) step = 1;
    if (stop < step) step = -step;

    return DoubleRange._(start, stop, step);
  }

  @override
  Iterator<double> get iterator => DoubleRangeIterator(start, stop, step);

  @override
  int get length {
    if (step == 0) throw Exception('Step cannot be 0');
    if (!step.isNegative) {
      if (start > stop) {
        throw Exception(
            'start cannot be greater than stop when step is positive!');
      }
      int ret = ((stop - start) / step).ceil();
      if (start + step * ret < stop + 1e-12) ret++;
      return ret;
    } else {
      if (start < stop) {
        throw Exception(
            'start cannot be less than stop when step is negative!');
      }
      int ret = ((start - stop) / -step).ceil();
      if (start + step * ret > stop - 1e-12) ret++;
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
    if(_pos == null) {
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
