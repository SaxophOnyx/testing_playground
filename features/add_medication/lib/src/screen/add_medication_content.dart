import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/services/text_formatter.dart';

import '../bloc/add_medication_bloc.dart';

class AddMedicationContent extends StatelessWidget {
  const AddMedicationContent({super.key});

  @override
  Widget build(BuildContext context) {
    final AddMedicationBloc bloc = context.read<AddMedicationBloc>();

    return Scaffold(
      appBar: AppBar(title: const Text('New Medication')),
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.pagePaddingLarge),
        child: BlocBuilder<AddMedicationBloc, AddMedicationState>(
          builder: (BuildContext context, AddMedicationState state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  onChanged: (String text) => bloc.add(UpdateInput(name: text)),
                  keyboardType: TextInputType.name,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.singleLineFormatter,
                  ],
                  decoration: InputDecoration(
                    labelText: 'Name',
                    errorText: state.nameError,
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
                  onChanged: (String text) => bloc.add(UpdateInput(expiresAt: text)),
                  enableInteractiveSelection: false,
                  keyboardType: TextInputType.datetime,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp('[0-9/-]')),
                    DateInputFormatter(),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Expires at',
                    hintText: '--/--/----',
                    errorText: state.expiresAtError,
                  ),
                ),
                const Spacer(),
                FilledButton(
                  onPressed: state.hasError ? null : () => bloc.add(const SubmitInput()),
                  child: const Text('Add medication'),
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
