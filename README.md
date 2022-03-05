# Range

Lazy and efficient 'range' iterables to generate values based on start, stop and step/count.

## Int ranges

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

### Linspace

`IntRange.linspace` returns an `Iterable<int>` with range [start, stop] with [count] elements in it.

```dart
print(1.linspace(10, 5));
```

> TODO ticks

## Extent

```dart
print(Extent.compute<int>(List<int>.generate(10, (i) => i * 10)..shuffle()));
```

### Ranging an Extent

```dart
print(Extent(5, 50).range(5));
```

> TODO DoubleRange

> TODO TimeRange

> TODO MonthRange

> TODO others
