part of 'medications_bloc.dart';

sealed class MedicationsEvent {
  const MedicationsEvent();
}

final class Initialize extends MedicationsEvent {
  const Initialize();
}

class AddMedication extends MedicationsEvent {
  const AddMedication();
}
