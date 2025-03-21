import 'package:flutter/foundation.dart';

final class MedicationsKeys {
  const MedicationsKeys._();

  static const String _fn = 'medications';

  static const ValueKey<String> addMedicationButton = ValueKey<String>('${_fn}add');
  static const ValueKey<String> useMedicationButton = ValueKey<String>('${_fn}use');
}
