part of grizzly.range.range;

//Copyright (c) 2011 Olov Lassus <olov.lassus@gmail.com>
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.

// Copyright (c) 2011 Ravi Teja Gudapati <tejainece@gmail.com>

/// Iterable of integers similar to python's range.
///
///     for(final i in IntRange(0, 5)) print(i);
class IntRange extends IterableBase<int> {
  /// Starting value of the range
  final int start;

  /// End value of the sequence
  final int stop;

  /// Spacing between values
  final int step;

  IntRange._(this.start, this.stop, this.step);

  /// Returns an iterable of integers from [start] inclusive to [stop] inclusive
  /// with [step].
  ///
  /// Examples:
  ///   IntRange(0, 5); // (0, 1, 2, 3, 4, 5)
  ///   IntRange(0, 10, 2); // (0, 2, 4, 6, 8, 10)
  ///   IntRange(5, -5); // (5, 4, 3, 2, 1, 0, -1, -2, -3, -4, -5)
  factory IntRange(int start, int stop, [int step = 1]) {
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
    return IntRange._(start, stop, step);
  }

  /// Returns an iterable of integers from 0 inclusive to [stop] inclusive with
  /// [step].
  ///
  ///   IntRange.until(5, 2); // (0, 2, 4)
  ///   IntRange.until(-5, -2); // (0, -2, -4)
  factory IntRange.until(int stop, [int step = 1]) => IntRange(0, stop, step);

  /// Returns an iterable of [count] integers from [start] inclusive to [stop]
  /// inclusive.
  ///
  ///     print(IntRange.linspace(1, 10, 5)); => (1, 3, 5, 7, 9)
  factory IntRange.linspace(int start, int stop, int count) {
    if (count <= 0) {
      throw ArgumentError.value(count, 'count', 'Must be a positive integer');
    } else if(count == 1) {
      return IntRange(start, stop, stop - start);
    }

    int step = 0;
    if (stop > start) {
      step = (stop - start) ~/ (count - 1);
    } else {
      step = (start - stop) ~/ (count - 1);
    }

    if (step == 0) step = 1;
    if (stop < start) {
      step = -step;
    }

    stop = start + (step * (count - 1));
    return IntRange(start, stop, step);
  }

  @override
  Iterator<int> get iterator => IntRangeIterator(start, stop, step);

  @override
  int get length {
    if (!step.isNegative) {
      return ((stop - start + 1) / step).ceil();
    } else {
      return ((start - stop + 1) / -step).ceil();
    }
  }

  @override
  bool get isEmpty => length == 0;

  @override
  int get hashCode => hash3(start, stop, step);

  @override
  bool operator ==(other) =>
      other is IntRange &&
      start == other.start &&
      stop == other.stop &&
      step == other.step;
}

class IntRangeIterator implements Iterator<int> {
  int? _pos;
  final int _start;
  final int _stop;
  final int _step;

  IntRangeIterator(int start, int stop, int step)
      : _start = start,
        _stop = stop,
        _step = step;

  @override
  int get current {
    if (_pos == null) {
      throw Exception('iterator not initialized');
    }

    return _pos!;
  }

  @override
  bool moveNext() {
    int next;
    if (_pos == null) {
      next = _start;
    } else {
      next = _pos! + _step;
    }

    if (_step > 0) {
      if (next > _stop) return false;
    } else {
      if (next < _stop) return false;
    }

    _pos = next;
    return true;
  }
}

extension IntRangeExt on int {
  IntRange get range => IntRange(0, this - 1);

  IntRange to(int stop, [int step = 1]) => IntRange(this, stop, step);

  IntRange take(int count, [int step = 1]) =>
      IntRange(this, this + (count * step), step);

  IntRange linspace(int stop, [int count = 50]) =>
      IntRange.linspace(this, stop, count);
}
