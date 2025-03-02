import '../../domain.dart';

final class FindStoredMedicationToUsePayload {
  final String medicationName;
  final int quantity;
  final DateTime usageDateTime;

  const FindStoredMedicationToUsePayload({
    required this.medicationName,
    required this.quantity,
    required this.usageDateTime,
  });
}

final class FindStoredMedicationToUseUseCase
    implements FutureUseCase<FindStoredMedicationToUsePayload, StoredMedication?> {
  final MedicationRepository _medicationRepository;

  const FindStoredMedicationToUseUseCase({
    required MedicationRepository medicationRepository,
  }) : _medicationRepository = medicationRepository;

  @override
  Future<StoredMedication?> execute(FindStoredMedicationToUsePayload payload) async {
    final Medication medication = await _medicationRepository.fetchMedication(
      name: payload.medicationName,
      createIfNotFound: false,
    );

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

    return null;
  }
}
