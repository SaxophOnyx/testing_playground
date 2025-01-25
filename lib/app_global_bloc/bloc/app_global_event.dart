part of 'app_global_bloc.dart';

sealed class AppGlobalEvent {
  const AppGlobalEvent();
}

final class CoreEventReceived extends AppGlobalEvent {
  final CoreEvent data;

  const CoreEventReceived(this.data);
}

final class DomainEventReceived extends AppGlobalEvent {
  final DomainEvent data;

  const DomainEventReceived(this.data);
}
