import 'package:collection/collection.dart';
import 'package:data/data.dart';

class FakeMedicationProvider implements MedicationProvider {
  final List<MedicationTableData> _medications = <MedicationTableData>[];

  List<MedicationTableData> get medications => _medications;

  @override
  Future<List<MedicationTableData>> fetchMedications() async {
    return List<MedicationTableData>.from(_medications);
  }

  @override
  Future<MedicationTableData?> searchMedicationByName({required String name}) async {
    return _medications.firstWhereOrNull(
      (MedicationTableData med) => med.name == name,
    );
  }

  @override
  Future<MedicationTableData> searchOrCreateMedicationByName({required String name}) async {
    final MedicationTableData? existingMedication = _medications.firstWhereOrNull(
      (MedicationTableData med) => med.name == name,
    );

    if (existingMedication != null) {
      return existingMedication;
    }

    final MedicationTableData newMedication = MedicationTableData(
      id: _medications.length + 1,
      name: name,
    );

    _medications.add(newMedication);

    return newMedication;
  }
}
