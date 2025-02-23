import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import '../bloc/medications_bloc.dart';
import 'medications_content.dart';

@RoutePage()
class MedicationsScreen extends StatelessWidget {
  const MedicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MedicationsBloc>(
      create: (_) => MedicationsBloc(
        appRouter: appLocator<AppRouter>(),
        fetchMedicationsUseCase: appLocator<FetchMedicationsUseCase>(),
        fetchStoredMedicationsUseCase: appLocator<FetchStoredMedicationsUseCase>(),
      )..add(const Initialize()),
      child: const MedicationsContent(),
    );
  }
}
