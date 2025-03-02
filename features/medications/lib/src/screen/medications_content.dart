import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/src/models/medication.dart';
import 'package:domain/src/models/stored_medication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../medications.dart';
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
            physics: state.isLoading
                ? const NeverScrollableScrollPhysics()
                : const ClampingScrollPhysics(),
            slivers: <Widget>[
              const SliverAppBar.medium(title: Text('Medications')),
              const SliverSizedBox(height: AppDimens.pageGap),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: AppDimens.pagePaddingSmall),
                sliver: SliverVisibility(
                  visible: state.storedMedications.isNotEmpty,
                  sliver: SliverList.separated(
                    itemCount: state.storedMedications.length,
                    itemBuilder: (BuildContext context, int index) {
                      final StoredMedication stored = state.storedMedications[index];
                      final Medication medication = state.medications[stored.medicationId]!;

                      return StoredMedicationCard(
                        name: medication.name,
                        quantity: stored.availableQuantity,
                        expiresAt: stored.expiresAt,
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
                              ? const Text('Error while loading medications')
                              : const Text('No medications'),
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
              heroTag: MedicationsRoute.name,
              onPressed: () => bloc.add(const AddMedication()),
              child: const Icon(Icons.add),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        );
      },
    );
  }
}
