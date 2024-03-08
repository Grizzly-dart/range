Iterable<({T a, T b})> zip<T>(Iterable<T> a, Iterable<T> b) sync* {
  final iter1 = a.iterator;
  final iter2 = b.iterator;

  while (true) {
    final has1 = iter1.moveNext();
    final has2 = iter2.moveNext();

    if (!has1 || !has2) {
      break;
    }

    yield (a: iter1.current, b: iter2.current);
  }
}
