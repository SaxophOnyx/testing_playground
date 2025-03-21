import 'package:flutter/foundation.dart';

final class AddMedicationKeys {
  const AddMedicationKeys._();

  static const String _fn = 'add_medication';

  static const ValueKey<String> nameTextField = ValueKey<String>('${_fn}name');
  static const ValueKey<String> quantityTextField = ValueKey<String>('${_fn}quantity');
  static const ValueKey<String> expiresAtTextField = ValueKey<String>('${_fn}expires');
  static const ValueKey<String> submitButton = ValueKey<String>('${_fn}submit');
}
