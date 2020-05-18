import 'package:collection/collection.dart';
import 'package:grizzly_range/grizzly_range.dart';
import 'package:grizzly_range/src/util/comparator.dart';
import 'package:quiver_hashcode/hashcode.dart';

/// Encloses an extent with a [lower] limit and [upper] limit, both inclusive
///
///     final extent = Extent<int>(5, 10);
class Extent<E> implements Comparable<Extent<E>> {
  /// Inclusive lower limit of the extent
  final E lower;

  /// Inclusive upper limit of the extent
  final E upper;

  final Comparator comparator;

  /// Creates an extent with [lower] limit and [upper] limit
  const Extent(this.lower, this.upper, {Comparator comparator})
      : comparator = (comparator ?? defaultComparator);

  /// Returns limit as [List]
  List<E> asList() => <E>[lower, upper];

  /// Compares if [this] and [other] are equal
  @override
  bool operator ==(other) {
    if (other is Extent<E>) {
      if (other.lower != lower) return false;
      if (other.upper != upper) return false;
      return true;
    } else if (other is Iterable<E>) {
      if (other.length != 2) return false;
      if (other.elementAt(0) != lower) return false;
      if (other.elementAt(1) != upper) return false;
      return true;
    }
    return false;
  }

  @override
  int get hashCode => hash2(lower, upper);

  bool has(E input) {
    if (comparator(lower, upper) == 0) return lower == input;

    if (isAscending) {
      return comparator(input, lower) >= 0 && comparator(input, upper) <= 0;
    } else {
      return comparator(input, upper) >= 0 && comparator(input, lower) <= 0;
    }
  }

  bool get isAscending => comparator(lower, upper) <= 0;

  bool get isDescending => comparator(lower, upper) > 0;

  Extent<E> get inverted => Extent<E>(upper, lower, comparator: comparator);

  Iterable<E> range(step) {
    if (E == int) {
      return IntRange(lower as int, upper as int, step) as Iterable<E>;
    } else if (E == double) {
      return DoubleRange(lower as double, upper as double, step) as Iterable<E>;
    } else if (E == DateTime) {
      if (step is Duration) {
        return TimeRange(lower as DateTime, upper as DateTime, step)
            as Iterable<E>;
      } else if (step is int) {
        return MonthRange(lower as DateTime, upper as DateTime, step)
            as Iterable<E>;
      } else {
        throw UnsupportedError(
            'step must be int or Duration for time range. but found $E');
      }
    }

    throw UnsupportedError('range is not supported for $E');
  }

  Iterable<E> linspace(count) {
    if (E == int) {
      return IntRange.linspace(lower as int, upper as int, count)
          as Iterable<E>;
    } else if (E == double) {
      return DoubleRange.linspace(lower as double, upper as double, count)
          as Iterable<E>;
    }

    throw UnsupportedError('range is not supported for $E');
  }

  @override
  int compareTo(Extent<E> other) {
    return comparator(lower, other.lower);
  }

  @override
  String toString() => 'Extent [$lower, $upper]';

  /// Computes an [Extent] from given [data] by finding the minimum and maximum.
  ///
  /// If E is [Comparable], [E.compareTo] is used for comparision. Otherwise,
  /// [comparator] argument is required.
  static Extent<E> compute<E>(Iterable<E> data, {Comparator comparator}) {
    comparator ??= defaultComparator;
    E min;
    E max;
    for (E d in data) {
      if (d == null) continue;

      if (max == null || comparator(d, max) > 0) max = d;
      if (min == null || comparator(d, min) < 0) min = d;
    }
    return Extent<E>(min, max, comparator: comparator);
  }

  static List<Extent<E>> consecutive<E>(Iterable<E> data,
      {Comparator comparator}) {
    if (data.length <= 1) return [];

    E start = data.first;
    final ret = <Extent<E>>[];
    for (final next in data.skip(1)) {
      ret.add(Extent<E>(start, next, comparator: comparator));
      start = next;
    }

    return ret;
  }

  static int search<E>(List<Extent<E>> extents, E value) {
    if (extents.isEmpty) return -1;
    Comparator comp = (e, value) {
      Extent extent = e;
      if (extent.has(value)) return 0;
      return extent.comparator(extent.lower, value);
    };
    if (extents.first.isDescending) {
      comp = (e, value) {
        Extent extent = e;
        if (extent.has(value)) return 0;
        return -extent.comparator(extent.lower, value);
      };
    }

    return binarySearch<dynamic>(extents, value, compare: comp);
  }
}
