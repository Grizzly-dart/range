import 'dart:math';

import 'package:grizzly_range/grizzly_range.dart';

class Data {
  int x;

  int y1;

  int y2;

  Data(this.x, this.y1, this.y2);
}

void main() {
  final rand = Random(12345);

  final extents = List.generate(11, (i) => i * 10).edgesToExtents();
  final data = List.generate(20, (index) => rand.nextInt(100));
  print(extents.computeBins(data));
  print(extents.computeCounts(data));
  print(extents.computeHistogram(data));
}
