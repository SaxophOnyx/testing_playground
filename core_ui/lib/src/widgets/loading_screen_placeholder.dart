import 'package:flutter/cupertino.dart';

import '../../core_ui.dart';

class LoadingScreenPlaceholder extends StatelessWidget {
  const LoadingScreenPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(AppDimens.pagePadding),
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
