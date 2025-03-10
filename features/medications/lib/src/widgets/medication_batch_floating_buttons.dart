import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class MedicationBatchFloatingButtons extends StatelessWidget {
  final bool isWidgetVisible;
  final bool isUseButtonVisible;
  final void Function() onAddMedication;
  final void Function() onUseMedication;

  const MedicationBatchFloatingButtons({
    super.key,
    required this.isWidgetVisible,
    required this.isUseButtonVisible,
    required this.onAddMedication,
    required this.onUseMedication,
  });

  @override
  Widget build(BuildContext context) {
    if (isWidgetVisible) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (isUseButtonVisible)
            Padding(
              padding: const EdgeInsets.only(bottom: AppDimens.widgetSeparatorMedium),
              child: FloatingActionButton(
                heroTag: null,
                onPressed: onUseMedication,
                child: const Icon(Icons.healing),
              ),
            ),
          FloatingActionButton(
            heroTag: null,
            onPressed: onAddMedication,
            child: const Icon(Icons.add),
          ),
        ],
      );
    }

    return const SizedBox();
  }
}
