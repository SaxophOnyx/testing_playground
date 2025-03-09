import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../navigation.dart';

final class AppRouterBuilders {
  const AppRouterBuilders._();

  static Route<T> scrollableBottomSheet<T>(
    BuildContext context,
    Widget child,
    AutoRoutePage<T> page,
  ) {
    return ModalBottomSheetRoute<T>(
      isScrollControlled: true,
      settings: page,
      builder: (BuildContext context) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * AppDimens.maxBottomSheetSizeCoefficient,
          ),
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
            child: child,
          ),
        );
      },
    );
  }
}
