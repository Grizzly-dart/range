part of grizzly.viz.scales.ranger;

class ConstantIterable<T> extends IterableBase<T> {
  final int length;

  final T constant;

  ConstantIterable(this.constant, [this.length = 10]);

  Iterator<T> get iterator => ConstantIterator<T>(constant, length);

  bool get isEmpty => length == 0;

  int get hashCode => hash2(constant, length);

  String toString() => 'ConstantIterable($constant, $length)';

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

  T get current => constant;

  bool moveNext() {
    _pos++;
    if (_pos < length) return true;
    return false;
  }
}
