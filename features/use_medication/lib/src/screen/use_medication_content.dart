import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../use_medication.dart';
import '../bloc/use_medication_bloc.dart';
import '../widgets/medication_search_result.dart';

class UseMedicationContent extends StatelessWidget {
  const UseMedicationContent({super.key});

  @override
  Widget build(BuildContext context) {
    final UseMedicationBloc bloc = context.read<UseMedicationBloc>();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.pagePadding),
        child: BlocBuilder<UseMedicationBloc, UseMedicationState>(
          builder: (BuildContext context, UseMedicationState state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      key: UseMedicationKeys.nameTextField,
                      onChanged: (String text) => bloc.add(UpdateInput(medicationName: text)),
                      keyboardType: TextInputType.name,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.singleLineFormatter,
                      ],
                      decoration: InputDecoration(
                        labelText: 'Medication Name',
                        errorText: state.medicationNameError.nullIfEmpty,
                      ),
                    ),
                    const SizedBox(height: AppDimens.widgetSeparatorMedium),
                    TextField(
                      key: UseMedicationKeys.quantityTextField,
                      onChanged: (String text) {
                        final int quantity = int.tryParse(text) ?? -1;
                        bloc.add(UpdateInput(quantity: quantity));
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        labelText: 'Quantity',
                        errorText: state.quantityError.nullIfEmpty,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimens.widgetSeparatorMedium),
                MedicationSearchResult(
                  didSearchForMedication: state.didSearchForMedication,
                  medication: state.batch,
                ),
                const SizedBox(height: AppDimens.bottomSheetButtonSeparator),
                if (state.batch == null)
                  FilledButton(
                    key: UseMedicationKeys.searchForMedicationButton,
                    onPressed: state.canSearchMedication
                        ? () => bloc.add(const SearchForMedication())
                        : null,
                    child: const Text('Search for a medication'),
                  ),
                if (state.batch != null)
                  FilledButton(
                    key: UseMedicationKeys.confirmUsageButton,
                    onPressed: () => bloc.add(const SubmitMedicationUsage()),
                    child: const Text('Confirm medication usage'),
                  ),
                const SizedBox(height: AppDimens.pagePadding),
              ],
            );
          },
        ),
      ),
    );
  }
}
