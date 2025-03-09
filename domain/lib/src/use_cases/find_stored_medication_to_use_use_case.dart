import '../../domain.dart';

final class FindStoredMedicationToUseUseCase
    implements FutureUseCase<FindStoredMedicationToUsePayload, StoredMedication?> {
  final MedicationRepository _medicationRepository;

  const FindStoredMedicationToUseUseCase({
    required MedicationRepository medicationRepository,
  }) : _medicationRepository = medicationRepository;

  @override
  Future<StoredMedication?> execute(FindStoredMedicationToUsePayload payload) async {
    final Medication? medication = await _medicationRepository.searchMedication(
      name: payload.medicationName,
    );

    if (medication != null) {
      final List<StoredMedication> stored = await _medicationRepository.fetchStoredMedications(
        medicationId: medication.id,
        minQuantity: payload.quantity,
        minExpirationDate: payload.usageDateTime,
      );

      if (stored.isNotEmpty) {
        return stored.reduce(
          (StoredMedication a, StoredMedication b) => a.expiresAt.isBefore(b.expiresAt) ? a : b,
        );
      }
    }

    return null;
  }
}
