# Range

Lazy and efficient 'range' iterables to generate values based on start, stop and step/count.

```dart
for (final i in 0.to(5)) {
  print(i);
}
```

Ranges can also be descending:

```dart
for (final i in 5.to(-5)) {
  print(i);
}
```

## Linspace

`IntRange.linspace` returns an `Iterable<int>` with range [start, stop] with [count] elements in it.

```dart
print(1.linspace(10, 5));
```

## Time ranges

```dart
print(TimeRange(
      DateTime(2019, 1, 1), DateTime(2019, 1, 20), Duration(days: 1)));
```

## Month range

```dart
print(MonthRange(DateTime(2020, 2, 29), DateTime(2032, 2, 30), 6));
```

# ticks

```dart
print(ticks(-100, 1000000, 10));
// => [-100000, 0, 100000, 200000, 300000, 400000, 500000, 600000, 700000, 800000, 900000]
```

# Extent

## Extent of list

```dart
print(List.generate(11, (i) => i * 10).findExtent()); // => Extent(0, 100)
```

## Ranging an Extent

```dart
print(Extent(5, 50).range(5));
```

## Generate random numbers

```dart
print(Extent(5, 50).rands(100));
```

# Extents

## Bin

```dart
  final extents = List.generate(11, (i) => i * 10).edgesToExtents();
  final data = extents.rands(20)!;
  print(extents.computeBins(data));
```

## Counts

```dart
  final extents = List.generate(11, (i) => i * 10).edgesToExtents();
  final data = extents.rands(20)!;
  print(extents.computeCounts(data));
```

## Histogram

```dart
  final extents = List.generate(11, (i) => i * 10).edgesToExtents();
  final data = extents.rands(20)!;
  print(extents.computeHistogram(data));
```
