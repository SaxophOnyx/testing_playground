import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../bloc/app_global_bloc.dart';

class AppErrorHandlerProvider extends StatelessWidget {
  final Widget child;

  const AppErrorHandlerProvider({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppGlobalBloc>(
      lazy: false,
      create: (_) => AppGlobalBloc(
        appEventObserver: appLocator<AppEventObserver>(),
      ),
      child: child,
    );
  }
}
