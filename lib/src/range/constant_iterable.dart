part of grizzly.range.range;

class ConstantIterable<T> extends IterableBase<T> {
  @override
  final int length;

  final T constant;

  ConstantIterable(this.constant, [this.length = 10]);

  @override
  Iterator<T> get iterator => ConstantIterator<T>(constant, length);

  @override
  bool get isEmpty => length == 0;

  @override
  int get hashCode => hash2(constant, length);

  @override
  String toString() => 'ConstantIterable($constant, $length)';

  @override
  bool operator ==(other) =>
      other is ConstantIterable &&
      constant == other.constant &&
      length == other.length;
}

class ConstantIterator<T> implements Iterator<T> {
  int _pos = -1;

  final int length;

  final T constant;

  ConstantIterator(this.constant, this.length);

  @override
  T get current => constant;

  @override
  bool moveNext() {
    _pos++;
    if (_pos < length) return true;
    return false;
  }
}
