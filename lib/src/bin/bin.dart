import 'package:grizzly_range/grizzly_range.dart';

typedef Accessor<L, D> = L Function(D input);

L identityAccessor<L, D>(D data) => data as L;

class Bin<L, D> {
  final Extent<L> limit;

  final Iterable<D> items;

  final Accessor<L, D> accessor;

  Bin(this.limit, this.items, {this.accessor});

  bool limitHas(L input) => limit.has(input);

  bool limitHasItem(D input) => limit.has(accessor(input));

  @override
  String toString() => 'Bin(limit: $limit, items: $items)';

  /// Bins the provided input [data] based on given [thresholds]
  static List<Bin<L, D>> compute<L, D>(Iterable<D> data, Iterable<L> thresholds,
      {Accessor<L, D> accessor, Comparator comparator}) {
    accessor ??= identityAccessor;
    final limits = thresholdsToLimits(thresholds, comparator: comparator);

    // final isAscending = limits.first.isAscending;
    final itemBins =
        List<List<D>>.generate(limits.length, (_) => [], growable: false);

    for (final D item in data) {
      final l = accessor(item);
      if (l == null) continue;
      final index = Extent.search(limits, l);
      if (index == -1) continue;
      itemBins[index].add(item);
    }

    final ret = <Bin<L, D>>[]..length = limits.length;
    for (int i = 0; i < limits.length; i++) {
      ret[i] = Bin<L, D>(limits[i], itemBins[i], accessor: accessor);
    }

    return ret;
  }

  /// Converts given [thresholds] into [Extent]s.
  static List<Extent<E>> thresholdsToLimits<E>(Iterable<E> thresholds,
      {Comparator comparator}) {
    if (thresholds.length < 2) {
      throw UnsupportedError('There should be atleast 2 elements in threshold');
    }

    final ret = <Extent<E>>[]..length = thresholds.length - 1;
    E prev = thresholds.first;
    int i = 0;
    bool isAscending;
    for (E e in thresholds.skip(1)) {
      final extent = Extent<E>(prev, e, comparator: comparator);
      if (isAscending == null) {
        isAscending = extent.isAscending;
      } else {
        if (isAscending != extent.isAscending) {
          throw UnsupportedError('Thresholds should be monotonic');
        }
      }
      ret[i++] = extent;
      prev = e;
    }

    return ret;
  }
}
