import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import '../bloc/use_medication_bloc.dart';
import 'use_medication_content.dart';

@RoutePage()
class UseMedicationScreen extends StatelessWidget {
  const UseMedicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UseMedicationBloc>(
      create: (_) => UseMedicationBloc(
        appRouter: appLocator<AppRouter>(),
        findMedicationBatchToConsumeUseCase: appLocator<FindMedicationBatchToConsumeUseCase>(),
        consumeMedicationBatchUseCase: appLocator<ConsumeMedicationBatchUseCase>(),
      ),
      child: const UseMedicationContent(),
    );
  }
}
