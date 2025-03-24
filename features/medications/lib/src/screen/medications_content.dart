import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/src/models/medication.dart';
import 'package:domain/src/models/medication_batch.dart';
import 'package:flutter/material.dart';

import '../bloc/medications_bloc.dart';
import '../widgets/medication_batch_card.dart';
import '../widgets/medication_batch_floating_buttons.dart';

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

              if (state.batches.isEmpty) {
                return const TextScreenPlaceholder(
                  text: 'No medications have been added yet',
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(AppDimens.pagePadding),
                itemCount: state.batches.length,
                itemBuilder: (BuildContext context, int index) {
                  final MedicationBatch batch = state.batches[index];
                  final Medication medication = state.medications[batch.medicationId]!;

                  return MedicationBatchCard(
                    medicationName: medication.name,
                    quantity: batch.quantity,
                    expiresAt: batch.expiresAt,
                    onDeletePressed: () => bloc.add(DeleteMedication(index)),
                  );
                },
              );
            },
          ),
          floatingActionButton: MedicationBatchFloatingButtons(
            isWidgetVisible: !(state.isLoading || state.error.isNotEmpty),
            isUseButtonVisible: state.batches.isNotEmpty,
            onAddMedication: () => bloc.add(const AddMedication()),
            onUseMedication: () => bloc.add(const UseMedication()),
          ),
        );
      },
    );
  }
}
