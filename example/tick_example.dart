import 'package:grizzly_range/grizzly_range.dart';

main() {
  print(ticks(1, 10, 5));
  print(ticks(-9, 9, 5));
  print(ticks(9, -9, 5));

  print(ticks(0.2, 0.8, 5));
}
