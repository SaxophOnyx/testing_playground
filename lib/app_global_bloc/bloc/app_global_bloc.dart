import 'dart:async';

import 'package:core/core.dart';
import 'package:domain/domain.dart';

part 'app_global_event.dart';
part 'app_global_state.dart';

class AppGlobalBloc extends Bloc<AppGlobalEvent, AppGlobalState> {
  final AppEventObserver _appEventObserver;
  final List<StreamSubscription<AppEvent>> _subscriptions = <StreamSubscription<AppEvent>>[];

  AppGlobalBloc({
    required AppEventObserver appEventObserver,
  })  : _appEventObserver = appEventObserver,
        super(const AppGlobalState()) {
    on<CoreEventReceived>(_onCoreEventReceived);
    on<DomainEventReceived>(_onDomainEventReceived);

    _subscriptions.add(
      _appEventObserver.observe<CoreEvent>(
        (CoreEvent event) => add(CoreEventReceived(event)),
      ),
    );

    _subscriptions.add(
      _appEventObserver.observe<DomainEvent>(
        (DomainEvent event) => add(DomainEventReceived(event)),
      ),
    );
  }

  Future<void> _onCoreEventReceived(
    CoreEventReceived event,
    Emitter<AppGlobalState> emit,
  ) async {
    switch (event.data) {
      case InternetConnectionLostEvent():
      // TODO(SaxophOnyx): Handle InternetConnectionLostEvent
      default:
    }
  }

  Future<void> _onDomainEventReceived(
    DomainEventReceived event,
    Emitter<AppGlobalState> emit,
  ) async {
    switch (event.data) {
      case UnauthorizedEvent():
      // TODO(SaxophOnyx): Handle UnauthorizedEvent
      default:
    }
  }

  @override
  Future<void> close() async {
    for (final StreamSubscription<AppEvent> subscription in _subscriptions) {
      await subscription.cancel();
    }

    await super.close();
  }
}
