import 'package:grizzly_range/grizzly_range.dart';

main() {
  print(MonthRange(DateTime(2020, 2, 29), DateTime(2032, 2, 30), 6).toList());
  print(MonthRange(DateTime(2019, 1, 31), DateTime(2022, 1, 31), 1).toList());

  print(MonthRange(DateTime(2032, 2, 29), DateTime(2020, 2, 29), 6).toList());
  print(MonthRange(DateTime(2022, 1, 31), DateTime(2019, 1, 31), 1).toList());
  print(MonthRange(DateTime(2022, 1, 1), DateTime(2019, 1, 1), 1).toList());
}
