import 'package:grizzly_range/grizzly_range.dart';

void main() {
  {
    final items = DurationRange(
        Duration(seconds: 10), Duration(seconds: 10), Duration(seconds: 1));
    print(items.toList());
    print(items.length);
  }
  {
    final items = DurationRange(
        Duration(seconds: 10), Duration(seconds: 20), Duration(seconds: 2));
    print(items.toList());
    print(items.length);
  }
  {
    final items = DurationRange(
        Duration(seconds: 10), Duration(seconds: 21), Duration(seconds: 2));
    print(items.toList());
    print(items.length);
  }
  {
    final items =
        DurationRange.until(Duration(seconds: 10), Duration(seconds: 2));
    print(items.toList());
    print(items.length);
  }
  {
    final items = to(Duration(seconds: 10), Duration(seconds: 2));
    print(items.toList());
    print(items.length);
  }
  {
    final items = to(Duration(seconds: 10), Duration(seconds: 2));
    print(items.toList());
    print(items.length);
  }
  {
    final items = Duration(seconds: 10).take(5, Duration(seconds: 2));
    print(items.toList());
    print(items.length);
  }
  {
    final items = Duration(seconds: 10).linspace(Duration(seconds: 20), 6);
    print(items.toList());
    print(items.length);
  }
  {
    final items = Duration(seconds: 10).linspace(Duration(seconds: 20), 1);
    print(items.toList());
    print(items.length);
  }
  {
    final items = Duration(seconds: 10).linspace(Duration(seconds: 20), 2);
    print(items.toList());
    print(items.length);
  }
}
