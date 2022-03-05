/*
typedef Accessor<L, D> = L Function(D input);

L identityAccessor<L, D>(D data) => data as L;

@experimental
class ProxyBin<L, D> {
  final Extent<L> limit;

  final Iterable<D> items;

  final Accessor<L, D> accessor;

  ProxyBin(this.limit, this.items, this.accessor);

  bool limitHas(L input) => limit.has(input);

  bool limitHasItem(D input) => limit.has(accessor(input));

  @override
  String toString() => 'Bin(limit: $limit, items: $items)';

  /// Bins the provided input [data] based on given [thresholds]
  static List<ProxyBin<L, D>> compute<L, D>(
      Iterable<D> data, Iterable<L> thresholds,
      {Accessor<L, D>? accessor, Comparator? comparator}) {
    accessor ??= identityAccessor;
    final limits = Extent.edgesToBins(thresholds, comparator: comparator);

    final itemBins =
        List<List<D>>.generate(limits.length, (_) => [], growable: false);

    for (final D item in data) {
      final l = accessor(item);
      if (l == null) continue;
      final index = Extent.search(limits, l);
      if (index == -1) continue;
      itemBins[index].add(item);
    }

    final ret = List<ProxyBin<L, D>?>.filled(limits.length, null);
    for (int i = 0; i < limits.length; i++) {
      ret[i] = ProxyBin<L, D>(limits[i], itemBins[i], accessor);
    }

    return ret.cast<ProxyBin<L, D>>();
  }
}*/
