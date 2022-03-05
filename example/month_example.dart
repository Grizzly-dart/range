import 'package:grizzly_range/grizzly_range.dart';

void main() {
  print(MonthRange(DateTime(2020, 2, 29), DateTime(2032, 2, 30), 6));
  print(MonthRange(DateTime(2019, 1, 31), DateTime(2022, 1, 31), 1));

  print(MonthRange(DateTime(2032, 2, 29), DateTime(2020, 2, 29), 6));
  print(MonthRange(DateTime(2022, 1, 31), DateTime(2019, 1, 31), 1));
  print(MonthRange(DateTime(2022, 1, 1), DateTime(2019, 1, 1), 1));
}
