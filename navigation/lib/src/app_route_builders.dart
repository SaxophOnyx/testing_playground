import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../navigation.dart';

final class AppRouteBuilders {
  const AppRouteBuilders._();

  static Route<T> dismissibleDialog<T>(
    _,
    Widget child,
    AutoRoutePage<T> page,
  ) {
    return PageRouteBuilder<T>(
      settings: page,
      barrierColor: Colors.black54,
      barrierDismissible: true,
      opaque: false,
      pageBuilder: (BuildContext context, Animation<double> animation, ___) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.defaultPagePadding,
            vertical: AppDimens.defaultPagePadding * 5,
          ),
          child: Center(
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          ),
        );
      },
    );
  }
}
