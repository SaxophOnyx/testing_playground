import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

import '../bloc/add_prescription_bloc.dart';
import 'add_prescription_content.dart';

@RoutePage()
class AddPrescriptionScreen extends StatelessWidget {
  const AddPrescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddPrescriptionBloc>(
      create: (_) => AddPrescriptionBloc(
        appRouter: appLocator<AppRouter>(),
        addPrescriptionUseCase: appLocator<AddPrescriptionUseCase>(),
      ),
      child: const AddPrescriptionContent(),
    );
  }
}
