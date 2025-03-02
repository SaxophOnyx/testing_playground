import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/src/models/medication.dart';
import 'package:domain/src/models/prescription.dart';
import 'package:domain/src/models/stored_medication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import '../bloc/prescriptions_bloc.dart';
import '../widgets/prescription_card.dart';

class PrescriptionsContent extends StatelessWidget {
  const PrescriptionsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final PrescriptionsBloc bloc = context.read<PrescriptionsBloc>();

    return BlocBuilder<PrescriptionsBloc, PrescriptionsState>(
      builder: (BuildContext context, PrescriptionsState state) {
        return Scaffold(
          body: CustomScrollView(
            physics: state.isLoading
                ? const NeverScrollableScrollPhysics()
                : const ClampingScrollPhysics(),
            slivers: <Widget>[
              const SliverAppBar.medium(title: Text('Prescriptions')),
              const SliverSizedBox(height: AppDimens.pageGap),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: AppDimens.pagePaddingSmall),
                sliver: SliverVisibility(
                  visible: state.prescriptions.isNotEmpty,
                  sliver: SliverList.separated(
                    itemCount: state.prescriptions.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Prescription prescription = state.prescriptions[index];
                      final StoredMedication stored =
                          state.storedMedications[prescription.storedMedicationId]!;
                      final Medication medication = state.medications[stored.medicationId]!;

                      return PrescriptionCard(
                        medicationName: medication.name,
                        quantity: prescription.quantity,
                        storedMedicationId: prescription.storedMedicationId,
                        dateTime: prescription.dateTime,
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: AppDimens.pageGap),
                  ),
                  replacementSliver: SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: state.isLoading
                          ? const CupertinoActivityIndicator()
                          : state.hasError
                              ? const Text('Error while loading prescriptions')
                              : const Text('No prescriptions'),
                    ),
                  ),
                ),
              ),
              const SliverSizedBox(height: AppDimens.pageGap),
            ],
          ),
          floatingActionButton: Visibility(
            visible: !(state.isLoading || state.hasError),
            child: FloatingActionButton(
              heroTag: PrescriptionsRoute.name,
              onPressed: () => bloc.add(const AddPrescription()),
              child: const Icon(Icons.add),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        );
      },
    );
  }
}
