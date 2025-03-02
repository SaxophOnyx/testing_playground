import 'package:core/core.dart';
import 'package:domain/domain.dart';

import '../../data.dart';

final class PrescriptionRepositoryImpl implements PrescriptionRepository {
  final AppDatabase _appDatabase;

  const PrescriptionRepositoryImpl({
    required AppDatabase appDatabase,
  }) : _appDatabase = appDatabase;

  @override
  Future<Prescription> addPrescription({
    required int storedMedicationId,
    required DateTime dateTime,
    required int quantity,
  }) async {
    final int id = await _appDatabase.into(_appDatabase.prescriptionTable).insert(
          PrescriptionTableCompanion.insert(
            prescriptionDateTime: dateTime,
            storedMedicationId: storedMedicationId,
            quantity: quantity,
          ),
        );

    return Prescription(
      id: id,
      dateTime: dateTime,
      storedMedicationId: storedMedicationId,
      quantity: quantity,
    );
  }

  @override
  Future<Prescription> deletePrescription({
    required int id,
  }) async {
    final List<PrescriptionTableData> entities =
        await (_appDatabase.select(_appDatabase.prescriptionTable)
              ..where(($PrescriptionTableTable row) => row.id.equals(id)))
            .get();

    await (_appDatabase.delete(_appDatabase.prescriptionTable)
          ..where(($PrescriptionTableTable row) => row.id.equals(id)))
        .go();

    final PrescriptionTableData entity = entities.first;

    return Prescription(
      id: entity.id,
      dateTime: entity.prescriptionDateTime,
      storedMedicationId: entity.storedMedicationId,
      quantity: entity.quantity,
    );
  }

  @override
  Future<List<Prescription>> fetchPrescriptions() async {
    final List<PrescriptionTableData> entities =
        await _appDatabase.select(_appDatabase.prescriptionTable).get();

    return entities.mapList(
      (PrescriptionTableData item) => Prescription(
        id: item.id,
        dateTime: item.prescriptionDateTime,
        storedMedicationId: item.storedMedicationId,
        quantity: item.quantity,
      ),
    );
  }
}
