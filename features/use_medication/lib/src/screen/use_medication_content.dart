import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../bloc/use_medication_bloc.dart';

class UseMedicationContent extends StatelessWidget {
  const UseMedicationContent({super.key});

  @override
  Widget build(BuildContext context) {
    final UseMedicationBloc bloc = context.read<UseMedicationBloc>();

    return Scaffold(
      appBar: AppBar(title: const Text('Use Medication')),
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.pagePaddingLarge),
        child: BlocBuilder<UseMedicationBloc, UseMedicationState>(
          builder: (BuildContext context, UseMedicationState state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
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
                const SizedBox(height: AppDimens.pageGap),
                TextField(
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
                const Spacer(),
                FilledButton(
                  onPressed: state.canSearchMedication
                      ? () => bloc.add(const SearchForMedication())
                      : null,
                  child: const Text('Search for medication'),
                ),
                const SizedBox(height: AppDimens.pagePaddingLarge),
              ],
            );
          },
        ),
      ),
    );
  }
}
