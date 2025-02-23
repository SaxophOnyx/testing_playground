import 'package:core/core.dart';
import 'package:domain/src/models/medication.dart';
import 'package:domain/src/models/stored_medication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../bloc/medications_bloc.dart';
import '../widgets/stored_medication_card.dart';

class MedicationsContent extends StatelessWidget {
  const MedicationsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final MedicationsBloc bloc = context.read<MedicationsBloc>();

    return BlocBuilder<MedicationsBloc, MedicationsState>(
      builder: (BuildContext context, MedicationsState state) {
        return Scaffold(
          body: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: <Widget>[
              const SliverAppBar(
                centerTitle: true,
                title: Text('Medications'),
              ),
              SliverVisibility(
                visible: !state.isLoading && state.storedMedications.isNotEmpty,
                sliver: SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList.separated(
                    itemCount: state.storedMedications.length,
                    itemBuilder: (BuildContext context, int index) {
                      final StoredMedication stored = state.storedMedications[index];
                      final Medication? maybeMedication = state.medications[stored.medicationId];

                      assert(
                        maybeMedication != null,
                        'Medication with ID ${stored.medicationId} not found',
                      );

                      final Medication medication = maybeMedication!;

                      return StoredMedicationCard(
                        name: medication.name,
                        quantity: stored.quantity,
                        expiresAt: stored.expiresAt,
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                  ),
                ),
                replacementSliver: SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: state.isLoading
                        ? const CupertinoActivityIndicator()
                        : Text(
                            state.hasError ? 'Error while loading medications' : 'No medications',
                          ),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => bloc.add(const AddMedication()),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
