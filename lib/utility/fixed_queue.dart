import 'dart:collection';

class FixedQueue<T> extends Iterable<T> {
  final _queue = Queue<T>();
  int queueSize;

  FixedQueue(this.queueSize);

  T get head => _queue.elementAt(0);

  void enqueue(T e) {
    _queue.addFirst(e);
    if (_queue.length > queueSize) {
      _queue.removeLast();
    }
  }

  @override
  Iterator<T> get iterator => _queue.iterator;
}
