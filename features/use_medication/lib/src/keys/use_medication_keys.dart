import 'package:flutter/foundation.dart';

final class UseMedicationKeys {
  const UseMedicationKeys._();

  static const String _fn = 'use_medication';

  static const ValueKey<String> nameTextField = ValueKey<String>('${_fn}name');
  static const ValueKey<String> quantityTextField = ValueKey<String>('${_fn}quantity');
  static const ValueKey<String> confirmUsageButton = ValueKey<String>('${_fn}confirm');
  static const ValueKey<String> searchForMedicationButton = ValueKey<String>('${_fn}search');
}
