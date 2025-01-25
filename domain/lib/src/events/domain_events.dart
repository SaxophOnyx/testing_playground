import 'package:core/core.dart';

sealed class DomainEvent extends AppEvent {
  const DomainEvent();
}

final class UnauthorizedEvent extends DomainEvent {
  const UnauthorizedEvent();
}
