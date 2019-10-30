import 'package:grizzly_range/grizzly_range.dart';

class Data {
  int x;

  int y1;

  int y2;

  Data(this.x, this.y1, this.y2);
}

main() {
  final bins = Bin.compute(<int>[11, 888, 10], <int>[0, 10, 100, 1000]);
  print(bins);
  // TODO

  // final bins1 = Bin.compute(<Data>[], <int>[0, 10, 100, 1000]);
  // TODO

  // TODO
}
