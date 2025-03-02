final class ValidationService {
  const ValidationService._();

  static String? validateName(String? name) {
    return (name != null && name.isNotEmpty) ? null : 'Invalid name';
  }

  static String? validateDate(DateTime? date) {
    return (date != null && date.isAfter(DateTime.now())) ? null : 'Invalid date';
  }
}
