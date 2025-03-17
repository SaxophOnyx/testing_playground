import 'package:domain/domain.dart';
import 'package:mocktail/mocktail.dart';
import 'package:navigation/navigation.dart';

class MockDiscardMedicationBatchUseCase extends Mock implements DiscardMedicationBatchUseCase {}

class MockFetchMedicationBatchesUseCase extends Mock implements FetchMedicationBatchesUseCase {}

class MockFetchMedicationsUseCase extends Mock implements FetchMedicationsUseCase {}

class FakeAppRouter extends Fake implements AppRouter {
  dynamic pushResult;

  FakeAppRouter({this.pushResult});

  @override
  Future<T?> push<T extends Object?>(PageRouteInfo route, {OnNavigationFailure? onFailure}) async {
    return pushResult as T?;
  }
}
