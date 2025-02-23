export 'extensions.dart';

extension ListExtension<T> on List<T> {
  List<E> mapList<E>(
    E Function(T) toElement, {
    bool growable = true,
  }) {
    return map<E>(toElement).toList(growable: growable);
  }
}
