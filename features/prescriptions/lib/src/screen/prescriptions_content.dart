import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/src/models/medication.dart';
import 'package:domain/src/models/prescription.dart';
import 'package:domain/src/models/stored_medication.dart';
import 'package:flutter/material.dart';

import '../bloc/prescriptions_bloc.dart';
import '../widgets/prescription_card.dart';

class PrescriptionsContent extends StatelessWidget {
  const PrescriptionsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrescriptionsBloc, PrescriptionsState>(
      builder: (BuildContext context, PrescriptionsState state) {
        return Scaffold(
          body: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: <Widget>[
              const SliverAppBar(
                centerTitle: true,
                floating: true,
                title: Text('Prescriptions'),
              ),
              const SliverSizedBox(height: 8),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                sliver: SliverList.separated(
                  itemCount: state.prescriptions.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Prescription prescription = state.prescriptions[index];
                    final StoredMedication storedMedication =
                        state.storedMedications[prescription.storedMedicationId]!;
                    final Medication medication = state.medications[storedMedication.medicationId]!;

                    return PrescriptionCard(
                      medicationName: medication.name,
                      quantity: prescription.quantity,
                      storedMedicationId: prescription.storedMedicationId,
                      dateTime: prescription.dateTime,
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                ),
              ),
              const SliverSizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}
