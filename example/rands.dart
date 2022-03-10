import 'dart:math';
import 'package:grizzly_range/grizzly_range.dart';

main() {
  print(Random(12345).ints(5));
  print(Random(12345).doubles(5));
  print(Random(12345).bools(5));
}
