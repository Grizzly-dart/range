part of grizzly.viz.scales.ranger;

class MonthRange extends IterableBase<DateTime> {
  /// Starting value of the range
  final DateTime start;

  /// End value of the sequence
  final DateTime stop;

  /// Spacing between values in months
  final int step;

  MonthRange._(this.start, this.stop, this.step);

  factory MonthRange(DateTime start, DateTime stop, [int stepInMonths]) {
    if (stepInMonths == null) {
      stepInMonths = 1;
    } else {
      if (stepInMonths <= 0) {
        throw ArgumentError.value(
            stepInMonths, 'stepInMonths', 'Must be greater than 0');
      }
    }
    if (stop.isBefore(start)) stepInMonths = -stepInMonths;
    return MonthRange._(start, stop, stepInMonths);
  }

  Iterator<DateTime> get iterator => MonthRangeIterator(start, stop, step);

  bool get isEmpty => length == 0;

  int get hashCode => hash3(start, stop, step);

  bool operator ==(other) =>
      other is MonthRange &&
      start == other.start &&
      stop == other.stop &&
      step == other.step;
}

class MonthRangeIterator implements Iterator<DateTime> {
  final DateTime _start;
  DateTime _pos;
  final DateTime _stop;
  final int _step;

  MonthRangeIterator(DateTime start, DateTime stop, int step)
      : _start = start,
        _stop = stop,
        _step = step;

  DateTime get current => _pos;

  bool moveNext() {
    DateTime next;
    if (_pos == null) {
      next = _start;
    } else {
      next = stepFunc(_pos, _step, _start.day);
    }

    if (!_step.isNegative) {
      if (next.isAfter(_stop)) return false;
    } else {
      if (next.isBefore(_stop)) return false;
    }

    _pos = next;
    return true;
  }

  static const _day = Duration(days: 1);

  static DateTime _add(DateTime date, int steps, int preferDay) {
    int year = steps ~/ 12;
    int months = steps % 12;

    DateTime ret = DateTime(
        date.year + year,
        date.month + months,
        date.day,
        date.hour,
        date.minute,
        date.second,
        date.millisecond,
        date.microsecond);

    if (date.day != ret.day) {
      while (ret.day > date.day || (date.day - ret.day) > 5) {
        ret = ret.subtract(_day);
      }
    }
    if (ret.day != preferDay) {
      final temp = DateTime(ret.year, ret.month, preferDay, ret.hour,
          ret.minute, ret.second, ret.millisecond, ret.microsecond);
      if (temp.day == preferDay) {
        ret = temp;
      }
    }

    return ret;
  }

  static DateTime _subtract(DateTime date, int steps, int preferDay) {
    int year = -steps ~/ 12;
    int months = -steps % 12;

    DateTime ret = DateTime(
        date.year - year,
        date.month - months,
        date.day,
        date.hour,
        date.minute,
        date.second,
        date.millisecond,
        date.microsecond);

    if (date.day != ret.day) {
      while (ret.day > date.day || (date.day - ret.day) > 5) {
        ret = ret.subtract(_day);
      }
    }
    if (ret.day != preferDay) {
      final temp = DateTime(ret.year, ret.month, preferDay, ret.hour,
          ret.minute, ret.second, ret.millisecond, ret.microsecond);
      if (temp.day == preferDay) {
        ret = temp;
      }
    }

    return ret;
  }

  static DateTime stepFunc(DateTime date, int steps, int preferDay) {
    if (!steps.isNegative) return _add(date, steps, preferDay);
    return _subtract(date, steps, preferDay);
  }
}

/*
class MonthRanger {
  const MonthRanger();

  List<DateTime> range(DateTime start, DateTime stop, [int months = 0]) {
    final values = <DateTime>[];

    DateTime time = start;
    while (time.isBefore(stop)) {
      values.add(time);
      time = step(time, months, start.day);
    }

    return values;
  }
}
*/
