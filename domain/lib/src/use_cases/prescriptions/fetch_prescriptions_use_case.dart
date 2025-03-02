import '../../../domain.dart';

final class FetchPrescriptionsUseCase implements FutureUseCase<void, List<Prescription>> {
  final PrescriptionRepository _prescriptionRepository;

  const FetchPrescriptionsUseCase({
    required PrescriptionRepository prescriptionRepository,
  }) : _prescriptionRepository = prescriptionRepository;

  @override
  Future<List<Prescription>> execute([void payload]) {
    return _prescriptionRepository.fetchPrescriptions();
  }
}
