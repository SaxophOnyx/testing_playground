import 'package:flutter/foundation.dart';

@immutable
class Medication {
  final int id;
  final String name;

  const Medication({
    required this.id,
    required this.name,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Medication && other.id == id && other.name == name;
  }

  @override
  int get hashCode {
    return Object.hash(id, name);
  }
}
