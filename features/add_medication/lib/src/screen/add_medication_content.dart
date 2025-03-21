import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/services/text_formatter.dart';

import '../bloc/add_medication_bloc.dart';
import '../keys/add_medication_keys.dart';

class AddMedicationContent extends StatelessWidget {
  const AddMedicationContent({super.key});

  @override
  Widget build(BuildContext context) {
    final AddMedicationBloc bloc = context.read<AddMedicationBloc>();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.pagePadding),
        child: BlocBuilder<AddMedicationBloc, AddMedicationState>(
          builder: (BuildContext context, AddMedicationState state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  key: AddMedicationKeys.nameTextField,
                  onChanged: (String text) => bloc.add(UpdateInput(name: text)),
                  keyboardType: TextInputType.name,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.singleLineFormatter,
                  ],
                  decoration: InputDecoration(
                    labelText: 'Medication name',
                    errorText: state.nameError.nullIfEmpty,
                  ),
                ),
                const SizedBox(height: AppDimens.widgetSeparatorMedium),
                TextField(
                  key: AddMedicationKeys.quantityTextField,
                  onChanged: (String text) => bloc.add(UpdateInput(quantity: text)),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    labelText: 'Initial quantity',
                    errorText: state.quantityError.nullIfEmpty,
                  ),
                ),
                const SizedBox(height: AppDimens.widgetSeparatorMedium),
                TextField(
                  key: AddMedicationKeys.expiresAtTextField,
                  onChanged: (String text) => bloc.add(UpdateInput(expiresAt: text)),
                  enableInteractiveSelection: false,
                  keyboardType: TextInputType.datetime,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp('[0-9/-]')),
                    DateInputFormatter(),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Expiration date (DD/MM/YYYY)',
                    hintText: '--/--/----',
                    errorText: state.expiresAtError.nullIfEmpty,
                  ),
                ),
                const SizedBox(height: AppDimens.bottomSheetButtonSeparator),
                FilledButton(
                  key: AddMedicationKeys.submitButton,
                  onPressed: () => bloc.add(const SubmitInput()),
                  child: const Text('Add new medication'),
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
