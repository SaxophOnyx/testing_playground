part of 'prescriptions_bloc.dart';

sealed class PrescriptionsEvent {
  const PrescriptionsEvent();
}

final class Initialize extends PrescriptionsEvent {
  const Initialize();
}

final class AddPrescription extends PrescriptionsEvent {
  const AddPrescription();
}
