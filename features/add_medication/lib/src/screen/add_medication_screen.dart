import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import '../bloc/add_medication_bloc.dart';
import 'add_medication_content.dart';

@RoutePage()
class AddMedicationScreen extends StatelessWidget {
  const AddMedicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddMedicationBloc>(
      create: (_) => AddMedicationBloc(
        appRouter: appLocator<AppRouter>(),
        addStoredMedicationUseCase: appLocator<AddStoredMedicationUseCase>(),
      ),
      child: const AddMedicationContent(),
    );
  }
}
