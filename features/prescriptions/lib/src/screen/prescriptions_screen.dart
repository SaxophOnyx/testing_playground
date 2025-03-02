import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import '../bloc/prescriptions_bloc.dart';
import 'prescriptions_content.dart';

@RoutePage()
class PrescriptionsScreen extends StatelessWidget {
  const PrescriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PrescriptionsBloc>(
      create: (_) => PrescriptionsBloc(
        appRouter: appLocator<AppRouter>(),
        fetchMedicationsUseCase: appLocator<FetchMedicationsUseCase>(),
        fetchStoredMedicationsUseCase: appLocator<FetchStoredMedicationsUseCase>(),
        fetchPrescriptionsUseCase: appLocator<FetchPrescriptionsUseCase>(),
      )..add(const Initialize()),
      child: const PrescriptionsContent(),
    );
  }
}
