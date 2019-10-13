import 'package:grizzly_range/grizzly_range.dart';

main() {
  print(TimeRange(
      DateTime(2019, 1, 1), DateTime(2019, 1, 20), Duration(days: 1)));
  print(TimeRange(
      DateTime(2019, 1, 20), DateTime(2019, 1, 1), Duration(days: 1)));

  print(
      TimeRange(DateTime(2019, 1, 1), DateTime(2019, 1, 20), Duration(days: 1))
          .length);
  print(
      TimeRange(DateTime(2019, 1, 20), DateTime(2019, 1, 1), Duration(days: 1))
          .length);
}
