part of 'medications_bloc.dart';

sealed class MedicationsEvent {
  const MedicationsEvent();
}

final class Initialize extends MedicationsEvent {
  const Initialize();
}

final class AddMedication extends MedicationsEvent {
  const AddMedication();
}

final class UseMedication extends MedicationsEvent {
  const UseMedication();
}
