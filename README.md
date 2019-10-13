# Range

Lazy and efficient 'range' iterables to generate values based on start, stop and step/count.

## Int ranges

```dart
print(IntRange(0, 5));
```

Ranges can also be descending:

```dart
print(IntRange(5, -5));
```

### Until

`IntRange.until` returns an `Iterable<int>` with range [0, stop] with provided step.

```dart
print(IntRange.until(50, 10));
```

### Linspace

`IntRange.linspace` returns an `Iterable<int>` with range [start, stop] with [count] elements in it.

```dart
print(IntRange.linspace(1, 10, 5));
```

> TODO DoubleRange

> TODO TimeRange

> TODO MonthRange

> TODO others
