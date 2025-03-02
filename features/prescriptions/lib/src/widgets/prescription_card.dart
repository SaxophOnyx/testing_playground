import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class PrescriptionCard extends StatelessWidget {
  final String medicationName;
  final int quantity;
  final int storedMedicationId;
  final DateTime dateTime;

  const PrescriptionCard({
    super.key,
    required this.medicationName,
    required this.quantity,
    required this.storedMedicationId,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textThemes = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.widgetPadding),
        child: Row(
          children: <Widget>[
            const SizedBox(width: AppDimens.widgetPadding),
            SizedBox.square(
              dimension: AppDimens.knobSizeLarge,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: medicationName.toColor(),
                ),
              ),
            ),
            const SizedBox(width: AppDimens.widgetPadding * 2),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    medicationName,
                    style: textThemes.titleMedium,
                  ),
                  Text(
                    '$quantity unit(s) from package $storedMedicationId',
                    style: textThemes.bodyMedium,
                  ),
                  const SizedBox(height: AppDimens.widgetPadding),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        DateFormat.yMMMMd().format(dateTime),
                        style: textThemes.labelLarge,
                      ),
                      const SizedBox(width: AppDimens.widgetPadding),
                      Text(
                        DateFormat('kk:mm').format(dateTime),
                        style: textThemes.labelLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
