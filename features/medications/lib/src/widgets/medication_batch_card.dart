import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class MedicationBatchCard extends StatelessWidget {
  final String medicationName;
  final int quantity;
  final DateTime expiresAt;

  final void Function() onDeletePressed;

  const MedicationBatchCard({
    super.key,
    required this.medicationName,
    required this.quantity,
    required this.expiresAt,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colors = theme.colorScheme;

    final bool isExpired = expiresAt.isBefore(DateTime.now());

    return Card(
      color: isExpired ? colors.errorContainer : null,
      child: SizedBox(
        height: AppDimens.cardMinHeight,
        child: Row(
          children: <Widget>[
            Container(
              width: 5,
              color: isExpired ? colors.error : Colors.greenAccent,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppDimens.cardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      isExpired ? '$medicationName (Expired)' : medicationName,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: isExpired ? colors.error : null,
                      ),
                    ),
                    Text(
                      '$quantity unit(s) until ${DateTimeUtils.formatDate(expiresAt)}',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: onDeletePressed,
              icon: const Icon(Icons.delete, color: Colors.grey),
            ),
            const SizedBox(width: AppDimens.cardPadding),
          ],
        ),
      ),
    );
  }
}
