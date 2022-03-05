import 'package:grizzly_range/grizzly_range.dart';
import 'package:grizzly_range/src/extent/extent.dart';

void main() {
  print(Extent(5, 50).range(5));
  print(Extent(5, 50).range(5));

  print(Extent(DateTime(2019, 1, 1), DateTime(2019, 1, 20))
      .range(Duration(days: 1))
      .toList());

  print(Extent.findExtent<int>(List<int>.generate(10, (i) => i * 10)..shuffle()));
  print(Extent.findExtent<DateTime>(
      List<DateTime>.generate(20, (i) => DateTime(2019, 1, i + 1))..shuffle()));
}
