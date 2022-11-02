import 'package:grizzly_range/grizzly_range.dart';

void main() {
  /*
  print(IntRange(5, -5));
  print(IntRange(10, 20, 2));
  print(IntRange(10, 20, 2).length);
  print(IntRange(10, 21, 2));
  print(IntRange(10, 21, 2).length);
  print(1.to(10));
  print(10.take(9));
  print(10.take(9, 10));
  print(10.take(1, 10));

  print(IntRange.until(5, 2));
  print(IntRange.until(-5, -2));

   */

  print(IntRange.linspace(0, 10, 5));
  print(IntRange.linspace(10, 0, 6));
  print(IntRange.linspace(-10, 0, 6));
}
