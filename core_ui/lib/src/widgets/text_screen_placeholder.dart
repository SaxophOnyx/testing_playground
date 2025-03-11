import 'package:flutter/material.dart';

import '../../core_ui.dart';

class TextScreenPlaceholder extends StatelessWidget {
  final String text;

  const TextScreenPlaceholder({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.pagePadding),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
        ),
      ),
    );
  }
}
