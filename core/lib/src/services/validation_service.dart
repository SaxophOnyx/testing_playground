final class ValidationService {
  const ValidationService._();

  static String validateName(String? name) {
    return (name != null && name.isNotEmpty) ? '' : 'Invalid name';
  }

  static String validateQuantity(int? quantity) {
    return (quantity != null && quantity > 0) ? '' : 'Invalid quantity';
  }

  static String validateDate(DateTime? date) {
    return (date != null && date.isAfter(DateTime.now())) ? '' : 'Invalid date';
  }
}
