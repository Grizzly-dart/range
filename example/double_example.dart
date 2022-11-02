import 'package:grizzly_range/grizzly_range.dart';

void main() {
  {
    final items = DoubleRange(0, 5);
    print('${items.length} $items');
  }
  {
    final items = DoubleRange(0, 5, 0.5);
    print('${items.length} $items');
  }
  {
    final items = DoubleRange(5, -5);
    print('${items.length} $items');
  }

  /*
  print(to(10.0));
  print(to(10.0, 2.0));
  print(to(10.0, 2));
  print(to(11.0, 2.2));
   */

  /*
  print(DoubleRange.until(5, 2));
  print(DoubleRange.until(-5, -2));
  print(DoubleRange.until(5, 2).length);
   */

  {
    final items = DoubleRange.linspace(-4.5, 20.5, 5);
    print('${items.length} $items');
  }

  {
    final items = DoubleRange.linspace(10, -8, 5);
    print('${items.length} $items');
  }
  {
    final items = DoubleRange.linspace(0, 1, 5);
    print('${items.length} $items');
  }
  {
    final items = DoubleRange.linspace(0, 1, 6);
    print('${items.length} $items');
  }
}
