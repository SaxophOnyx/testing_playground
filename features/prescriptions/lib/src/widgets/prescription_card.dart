import 'package:core/core.dart';
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
    return ListTile(
      isThreeLine: true,
      title: Text(medicationName),
      subtitle: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Text('$quantity unit(s) from package $storedMedicationId'),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(DateFormat.yMMMMd().format(dateTime)),
              const SizedBox(width: 8),
              Text(DateFormat('kk:mm').format(dateTime)),
            ],
          ),
          // TODO(SaxophOnyx): Remove mock
          const Align(
            alignment: Alignment.bottomRight,
            child: Text(
              'Unconfirmed',
              style: TextStyle(color: Colors.orange),
            ),
          ),
        ],
      ),
    );
  }
}
