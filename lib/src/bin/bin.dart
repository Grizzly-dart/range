import 'package:grizzly_range/grizzly_range.dart';
import 'package:text_table/text_table.dart';

extension BinExtentsExt<T> on Extents<T> {
  List<Bin<T>> computeBins(Iterable<T> data) {
    final bins = this.map((e) => Bin<T>(e, <T>[])).toList();

    for (final T item in data) {
      bins.addSample(item);
    }

    return bins;
  }

  List<BinCount<T>> computeCounts(Iterable<T> data) {
    final bins = this.map((e) => BinCount<T>(e, 0)).toList();

    for (final T item in data) {
      bins.addSample(item);
    }

    return bins;
  }

  Future<List<BinCount<T>>> computeCountsStream(Stream<T> data) async {
    final bins = this.map((e) => BinCount<T>(e, 0)).toList();

    await for (final T item in data) {
      bins.addSample(item);
    }

    return bins;
  }

  List<HistBin<T>> computeHistogram(Iterable<T> data) =>
      computeCounts(data).normalize();

  Future<List<HistBin<T>>> computeHistogramStream(Stream<T> data) async {
    final bins = await computeCountsStream(data);
    return bins.normalize();
  }
}

class Bin<T> implements HasExtent<T> {
  final Extent<T> extent;

  final List<T> samples;

  Bin(this.extent, this.samples);

  @override
  String toString() => 'Bin(extent: $extent, samples: $samples)';
}

typedef Bins<T> = List<Bin<T>>;

extension BinsExt<T> on Bins<T> {
  void addSample(T item) {
    if (item == null) return;
    final index = searchExtent(item);
    if (index == -1) return;
    this[index].samples.add(item);
  }

  List<BinCount<T>> toCounts() =>
      map((e) => BinCount(e.extent, e.samples.length)).toList();


  String asTable({TableRenderer? renderer}) {
    renderer ??= _renderer;
    return renderer.render(
        map((e) => [e.extent.lower, e.extent.upper, e.samples]),
        columns: ['Lower', 'Upper', 'Samples']);
  }
}

class BinCount<T> implements HasExtent<T> {
  final Extent<T> extent;
  int count = 0;

  BinCount(this.extent, this.count);

  @override
  String toString() => 'BinCount(extent: $extent, count: $count)';
}

typedef BinCounts<T> = List<BinCount<T>>;

extension BinCountsExt<T> on BinCounts<T> {
  void addSample(T item) {
    if (item == null) return;
    final index = searchExtent(item);
    if (index == -1) return;
    this[index].count++;
  }

  Histogram<T> normalize() {
    final total = fold<int>(0, (int v, BinCount<T> e) => v + e.count);
    return map((e) => HistBin(e.extent, e.count / total)).toList();
  }

  String asTable({TableRenderer? renderer}) {
    renderer ??= _renderer;
    return renderer.render(
        map((e) => [e.extent.lower, e.extent.upper, e.count]),
        columns: ['Lower', 'Upper', 'Count']);
  }
}

class HistBin<T> implements HasExtent<T> {
  final Extent<T> extent;
  double density = 0;

  HistBin(this.extent, this.density);

  @override
  String toString() => 'HistBin(extent: $extent, density: $density)';
}

typedef Histogram<T> = List<HistBin<T>>;

extension HistogramExt<T> on Histogram<T> {
  void normalize() {
    final total = fold<double>(0, (double v, HistBin<T> e) => v + e.density);
    for (final bin in this) {
      bin.density = bin.density / total;
    }
  }

  double get density => fold(0.0, (v, e) => v + e.density);

  String asTable({TableRenderer? renderer}) {
    renderer ??= _renderer;
    return renderer.render(
        map((e) => [e.extent.lower, e.extent.upper, e.density]),
        columns: ['Lower', 'Upper', 'Density']);
  }
}

const _renderer = TableRenderer();
