import 'package:core/core.dart';
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
    return ListTile(
      isThreeLine: true,
      title: Text(name),
      leading: SizedBox(
        width: 16,
        height: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _stringToColor(name),
          ),
        ),
      ),
      subtitle: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text('$quantity unit(s) available'),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text('Expires on ${DateFormat.yMMMMd().format(expiresAt)}'),
          ),
        ],
      ),
    );
  }

  Color _stringToColor(String input) {
    final int hash = input.hashCode;

    final int r = (hash & 0xFF0000) >> 16;
    final int g = (hash & 0x00FF00) >> 8;
    final int b = hash & 0x0000FF;

    return Color.fromARGB(255, r, g, b);
  }
}
