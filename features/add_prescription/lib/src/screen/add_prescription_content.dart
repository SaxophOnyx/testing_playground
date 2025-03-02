import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../bloc/add_prescription_bloc.dart';

class AddPrescriptionContent extends StatelessWidget {
  const AddPrescriptionContent({super.key});

  @override
  Widget build(BuildContext context) {
    final AddPrescriptionBloc bloc = context.read<AddPrescriptionBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Prescription'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.pagePaddingLarge),
        child: BlocBuilder<AddPrescriptionBloc, AddPrescriptionState>(
          builder: (BuildContext context, AddPrescriptionState state) {
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
                    labelText: 'Medication name',
                    errorText: state.medicationNameError,
                  ),
                ),
                const SizedBox(height: AppDimens.pageGap),
                TextField(
                  onChanged: (String text) => bloc.add(UpdateInput(quantity: text)),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    labelText: 'Quantity',
                    errorText: state.quantityError,
                  ),
                ),
                const SizedBox(height: AppDimens.pageGap),
                TextField(
                  onChanged: (String text) => bloc.add(UpdateInput(dateTime: text)),
                  enableInteractiveSelection: false,
                  keyboardType: TextInputType.datetime,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp('[0-9/-]')),
                    DateInputFormatter(),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Date',
                    hintText: '--/--/----',
                    errorText: state.dateTimeError,
                  ),
                ),
                const Spacer(),
                FilledButton(
                  onPressed: state.hasError ? null : () => bloc.add(const SubmitInput()),
                  child: const Text('Add prescription'),
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
