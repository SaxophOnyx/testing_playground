import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/src/models/medication.dart';
import 'package:domain/src/models/stored_medication.dart';
import 'package:flutter/material.dart';

import '../bloc/medications_bloc.dart';
import '../widgets/stored_medication_card.dart';
import '../widgets/stored_medication_floating_buttons.dart';

class MedicationsContent extends StatelessWidget {
  const MedicationsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final MedicationsBloc bloc = BlocProvider.of<MedicationsBloc>(context);

    return BlocBuilder<MedicationsBloc, MedicationsState>(
      builder: (BuildContext context, MedicationsState state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Medications')),
          body: Builder(
            builder: (BuildContext context) {
              if (state.isLoading) {
                return const LoadingScreenPlaceholder();
              }

              if (state.error.isNotEmpty) {
                return TextScreenPlaceholder(text: state.error);
              }

              if (state.storedMedications.isEmpty) {
                return const TextScreenPlaceholder(
                  text: 'No stored medication have been added yet',
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(AppDimens.pagePadding),
                itemCount: state.storedMedications.length,
                itemBuilder: (BuildContext context, int index) {
                  final StoredMedication stored = state.storedMedications[index];
                  final Medication medication = state.medications[stored.medicationId]!;

                  return StoredMedicationCard(
                    name: medication.name,
                    quantity: stored.quantity,
                    expiresAt: stored.expiresAt,
                    onDeletePressed: () => bloc.add(DeleteMedication(index)),
                  );
                },
              );
            },
          ),
          floatingActionButton: StoredMedicationFloatingButtons(
            isWidgetVisible: !(state.isLoading || state.error.isNotEmpty),
            isUseButtonVisible: state.storedMedications.isNotEmpty,
            onAddMedication: () => bloc.add(const AddMedication()),
            onUseMedication: () => bloc.add(const UseMedication()),
          ),
        );
      },
    );
  }
}
