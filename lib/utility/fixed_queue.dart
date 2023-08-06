import 'package:equatable/equatable.dart';

class FixedQueue<T> extends Iterable<T> with EquatableMixin {
  final List<T> queue;
  final int queueSize;

  const FixedQueue({required this.queueSize, this.queue = const []});

  T get head => queue.first;

  FixedQueue<T> enqueue(T e) {
    final enqueued = [e, ...queue];
    if (enqueued.length > queueSize) {
      enqueued.removeLast();
    }
    return copyWith(queue: enqueued);
  }

  @override
  Iterator<T> get iterator => queue.iterator;

  FixedQueue<T> copyWith({int? queueSize, List<T>? queue}) {
    return FixedQueue<T>(
      queueSize: queueSize ?? this.queueSize,
      queue: queue ?? this.queue,
    );
  }

  @override
  List<Object?> get props => [queue, queueSize];
}
