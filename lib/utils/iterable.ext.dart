extension ExtendedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E element, int index) function) {
    var index = 0;
    return map((E element) => function(element, index++));
  }
}
