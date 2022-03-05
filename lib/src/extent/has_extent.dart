import 'package:collection/collection.dart';

import 'extent.dart';

abstract class HasExtent<T> {
  Extent<T> get extent;
}

extension HasExtentListExt<T> on List<HasExtent<T>> {
  int searchExtent(T value) {
    if (isEmpty) return -1;

    Comparator comp;
    if (this.first.extent.isAscending) {
      comp = (e, value) {
        Extent extent = (e as HasExtent).extent;
        if (extent.has(value)) return 0;
        return extent.comparator(extent.lower, value);
      };
    } else {
      comp = (e, value) {
        Extent extent = (e as HasExtent).extent;
        if (extent.has(value)) return 0;
        return -extent.comparator(extent.lower, value);
      };
    }

    return binarySearch<dynamic>(this, value, compare: comp);
  }
}