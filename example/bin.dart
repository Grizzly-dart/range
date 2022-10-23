import 'dart:math';

import 'package:grizzly_range/grizzly_range.dart';

void main() {
  final rand = Random(12345);

  final extents = List.generate(11, (i) => i * 10).edgesToExtents();
  final data = extents.rands(20, source: rand)!.toList();

  print(extents.computeBins(data).asTable());
  print(extents.computeCounts(data).asTable());
  print(extents.computeHistogram(data).asTable());
}
