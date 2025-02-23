import '../../domain.dart';

final class CreatedStoredMedication {
  final StoredMedication storedMedication;
  final Medication associatedMedication;

  const CreatedStoredMedication({
    required this.storedMedication,
    required this.associatedMedication,
  });
}
