import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class MedicationSearchResult extends StatelessWidget {
  final bool didSearchForMedication;
  final StoredMedication? medication;

  const MedicationSearchResult({
    super.key,
    required this.didSearchForMedication,
    required this.medication,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Card.outlined(
      color: Colors.transparent,
      child: SizedBox(
        height: AppDimens.cardMinHeight,
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.cardPadding),
          child: Center(
            child: Builder(
              builder: (BuildContext context) {
                if (didSearchForMedication) {
                  final StoredMedication? maybeMedication = medication;

                  if (maybeMedication != null) {
                    return Text(
                      'Medication ${maybeMedication.id}',
                      style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
                    );
                  }

                  return Text(
                    'No suitable medications found',
                    style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}
