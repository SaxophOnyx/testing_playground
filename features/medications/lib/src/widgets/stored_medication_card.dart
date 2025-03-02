import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class StoredMedicationCard extends StatelessWidget {
  final String name;
  final int quantity;
  final DateTime expiresAt;

  const StoredMedicationCard({
    super.key,
    required this.name,
    required this.quantity,
    required this.expiresAt,
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
                  color: name.toColor(),
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
                    name,
                    style: textThemes.titleMedium,
                  ),
                  Text(
                    '$quantity unit(s) available',
                    style: textThemes.bodyMedium,
                  ),
                  const SizedBox(height: AppDimens.widgetPadding),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Expires on ${DateFormat.yMMMMd().format(expiresAt)}',
                      style: textThemes.labelLarge,
                    ),
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
