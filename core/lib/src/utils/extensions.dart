import 'package:flutter/material.dart';

import '../../core.dart';

extension LocaleObserver on String {
  String watchTr(
    BuildContext context, {
    List<String>? args,
    Map<String, String>? namedArgs,
    String? gender,
  }) {
    context.locale;
    return this.tr(args: args, namedArgs: namedArgs, gender: gender);
  }
}

extension ListExtension<T> on List<T> {
  List<E> mapList<E>(
    E Function(T) toElement, {
    bool growable = true,
  }) {
    return map<E>(toElement).toList(growable: growable);
  }

  Map<K, V> toMap<K, V>({
    required Function(T item) key,
    required Function(T item) value,
  }) {
    return <K, V>{
      for (final T item in this) key(item): value(item),
    };
  }
}

extension StringExtension on String {
  Color toColor() {
    final int hash = hashCode;

    final int r = (hash & 0xFF0000) >> 16;
    final int g = (hash & 0x00FF00) >> 8;
    final int b = hash & 0x0000FF;

    return Color.fromARGB(255, r, g, b);
  }
}
