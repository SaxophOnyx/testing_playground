import 'package:bloc_test/bloc_test.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medications/src/bloc/medications_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'fakes.dart';

void main() {
  late FakeAppRouter appRouter;
  late MockFetchMedicationsUseCase fetchMedicationsUseCase;
  late MockFetchMedicationBatchesUseCase fetchMedicationBatchesUseCase;
  late MockDiscardMedicationBatchUseCase discardMedicationBatchUseCase;
  late MedicationsBloc blocUnderTesting;

  setUpAll(() {
    registerFallbackValue(const DiscardMedicationBatchPayload(batchId: 0));
  });

  setUp(() {
    appRouter = FakeAppRouter();
    fetchMedicationsUseCase = MockFetchMedicationsUseCase();
    fetchMedicationBatchesUseCase = MockFetchMedicationBatchesUseCase();
    discardMedicationBatchUseCase = MockDiscardMedicationBatchUseCase();

    blocUnderTesting = MedicationsBloc(
      appRouter: appRouter,
      fetchMedicationsUseCase: fetchMedicationsUseCase,
      fetchMedicationBatchesUseCase: fetchMedicationBatchesUseCase,
      discardMedicationBatchUseCase: discardMedicationBatchUseCase,
    );
  });

  tearDown(() {
    blocUnderTesting.close();
  });

  group('Initialize', () {
    blocTest(
      'Initial state is MedicationsState.initial',
      build: () => blocUnderTesting,
      verify: (MedicationsBloc bloc) => expect(bloc.state, const MedicationsState.initial()),
    );

    blocTest<MedicationsBloc, MedicationsState>(
      'correctly loads data when both use cases succeed',
      setUp: () {
        when(() => fetchMedicationsUseCase.execute()).thenAnswer(
          (_) async => <Medication>[
            const Medication(id: 1, name: 'Med 1'),
            const Medication(id: 2, name: 'Med 2'),
          ],
        );
        when(() => fetchMedicationBatchesUseCase.execute()).thenAnswer(
          (_) async => <MedicationBatch>[
            MedicationBatch(
              id: 1,
              medicationId: 1,
              quantity: 10,
              initialQuantity: 10,
              expiresAt: DateTime(0),
            ),
          ],
        );
      },
      build: () => blocUnderTesting,
      act: (MedicationsBloc bloc) => bloc.add(const Initialize()),
      expect: () => <MedicationsState>[
        MedicationsState(
          medications: const <int, Medication>{
            1: Medication(id: 1, name: 'Med 1'),
            2: Medication(id: 2, name: 'Med 2'),
          },
          batches: <MedicationBatch>[
            MedicationBatch(
              id: 1,
              medicationId: 1,
              quantity: 10,
              initialQuantity: 10,
              expiresAt: DateTime(0),
            ),
          ],
          isLoading: false,
          error: '',
        ),
      ],
    );

    blocTest<MedicationsBloc, MedicationsState>(
      'emits error state if fetching medications fails',
      setUp: () {
        when(() => fetchMedicationsUseCase.execute())
            .thenThrow(Exception('Failed to fetch medications'));
        when(() => fetchMedicationBatchesUseCase.execute())
            .thenAnswer((_) async => <MedicationBatch>[]);
      },
      build: () => blocUnderTesting,
      act: (MedicationsBloc bloc) => bloc.add(const Initialize()),
      expect: () => <MedicationsState>[
        const MedicationsState(
          medications: <int, Medication>{},
          batches: <MedicationBatch>[],
          isLoading: false,
          error: 'Error while loading medications',
        ),
      ],
    );

    blocTest<MedicationsBloc, MedicationsState>(
      'emits error state if fetching medication batches fails',
      setUp: () {
        when(() => fetchMedicationsUseCase.execute()).thenAnswer((_) async => <Medication>[]);
        when(() => fetchMedicationBatchesUseCase.execute())
            .thenThrow(Exception('Failed to fetch medication batches'));
      },
      build: () => blocUnderTesting,
      act: (MedicationsBloc bloc) => bloc.add(const Initialize()),
      expect: () => <MedicationsState>[
        const MedicationsState(
          medications: <int, Medication>{},
          batches: <MedicationBatch>[],
          isLoading: false,
          error: 'Error while loading medications',
        ),
      ],
    );
  });

  group('AddMedication', () {
    blocTest<MedicationsBloc, MedicationsState>(
      'does not modify state when push returns null',
      setUp: () {
        appRouter.pushResult = null;
      },
      build: () => blocUnderTesting,
      act: (MedicationsBloc bloc) => bloc.add(const AddMedication()),
      expect: () => <MedicationsState>[],
    );

    blocTest<MedicationsBloc, MedicationsState>(
      'adds new batch and does not modify medications map when medication is already present',
      setUp: () {
        appRouter.pushResult = AddMedicationBatchResult(
          medication: const Medication(
            id: 1,
            name: 'Existing Med',
          ),
          batch: MedicationBatch(
            id: 2,
            medicationId: 1,
            quantity: 5,
            initialQuantity: 5,
            expiresAt: DateTime(0),
          ),
        );
      },
      build: () => blocUnderTesting,
      seed: () => const MedicationsState(
        medications: <int, Medication>{1: Medication(id: 1, name: 'Existing Med')},
        batches: <MedicationBatch>[],
        isLoading: false,
        error: '',
      ),
      act: (MedicationsBloc bloc) => bloc.add(const AddMedication()),
      expect: () => <MedicationsState>[
        MedicationsState(
          medications: const <int, Medication>{1: Medication(id: 1, name: 'Existing Med')},
          batches: <MedicationBatch>[
            MedicationBatch(
              id: 2,
              medicationId: 1,
              quantity: 5,
              initialQuantity: 5,
              expiresAt: DateTime(0),
            )
          ],
          isLoading: false,
          error: '',
        ),
      ],
    );

    blocTest<MedicationsBloc, MedicationsState>(
      'adds new batch and medication when neither is presented',
      setUp: () {
        const Medication newMedication = Medication(id: 2, name: 'New Med');
        final MedicationBatch newBatch = MedicationBatch(
          id: 3,
          medicationId: 2,
          quantity: 10,
          initialQuantity: 10,
          expiresAt: DateTime(0),
        );

        appRouter.pushResult = AddMedicationBatchResult(
          medication: newMedication,
          batch: newBatch,
        );
      },
      seed: () {
        return const MedicationsState(
          medications: <int, Medication>{},
          batches: <MedicationBatch>[],
          isLoading: false,
          error: '',
        );
      },
      build: () => blocUnderTesting,
      act: (MedicationsBloc bloc) => bloc.add(const AddMedication()),
      expect: () => <MedicationsState>[
        MedicationsState(
          medications: const <int, Medication>{2: Medication(id: 2, name: 'New Med')},
          batches: <MedicationBatch>[
            MedicationBatch(
              id: 3,
              medicationId: 2,
              quantity: 10,
              initialQuantity: 10,
              expiresAt: DateTime(0),
            )
          ],
          isLoading: false,
          error: '',
        ),
      ],
    );
  });

  group('UseMedication', () {
    blocTest<MedicationsBloc, MedicationsState>(
      'changes nothing if push returns null',
      setUp: () {
        appRouter.pushResult = null;
      },
      build: () => blocUnderTesting,
      act: (MedicationsBloc bloc) => bloc.add(const UseMedication()),
      expect: () => <MedicationsState>[],
    );

    blocTest<MedicationsBloc, MedicationsState>(
      'updates batch in list if updated batch has non-zero quantity',
      setUp: () {
        appRouter.pushResult = MedicationBatch(
          id: 1,
          medicationId: 1,
          quantity: 5,
          initialQuantity: 10,
          expiresAt: DateTime(0),
        );
      },
      build: () => blocUnderTesting,
      seed: () => MedicationsState(
        medications: const <int, Medication>{
          1: Medication(id: 1, name: 'Existing Med'),
        },
        batches: <MedicationBatch>[
          MedicationBatch(
            id: 1,
            medicationId: 1,
            quantity: 10,
            initialQuantity: 10,
            expiresAt: DateTime(0),
          ),
        ],
        isLoading: false,
        error: '',
      ),
      act: (MedicationsBloc bloc) => bloc.add(const UseMedication()),
      expect: () => <MedicationsState>[
        MedicationsState(
          medications: const <int, Medication>{
            1: Medication(id: 1, name: 'Existing Med'),
          },
          batches: <MedicationBatch>[
            MedicationBatch(
              id: 1,
              medicationId: 1,
              quantity: 5,
              initialQuantity: 10,
              expiresAt: DateTime(0),
            ),
          ],
          isLoading: false,
          error: '',
        ),
      ],
    );

    blocTest<MedicationsBloc, MedicationsState>(
      'removes batch if updated batch has zero quantity',
      setUp: () {
        appRouter.pushResult = MedicationBatch(
          id: 1,
          medicationId: 1,
          quantity: 0,
          initialQuantity: 10,
          expiresAt: DateTime(0),
        );
      },
      build: () => blocUnderTesting,
      seed: () {
        return MedicationsState(
          medications: const <int, Medication>{
            1: Medication(id: 1, name: 'Existing Med'),
          },
          batches: <MedicationBatch>[
            MedicationBatch(
              id: 1,
              medicationId: 1,
              quantity: 10,
              initialQuantity: 10,
              expiresAt: DateTime(0),
            ),
          ],
          isLoading: false,
          error: '',
        );
      },
      act: (MedicationsBloc bloc) => bloc.add(const UseMedication()),
      expect: () => <MedicationsState>[
        const MedicationsState(
          medications: <int, Medication>{
            1: Medication(id: 1, name: 'Existing Med'),
          },
          batches: <MedicationBatch>[],
          isLoading: false,
          error: '',
        ),
      ],
    );
  });

  group('DeleteMedication', () {
    blocTest<MedicationsBloc, MedicationsState>(
      'removes batch if it is present in the state',
      build: () => blocUnderTesting,
      setUp: () {
        when(() => discardMedicationBatchUseCase.execute(any())).thenAnswer((_) async {});
      },
      seed: () {
        return MedicationsState(
          medications: const <int, Medication>{
            1: Medication(id: 1, name: 'Existing Med'),
          },
          batches: <MedicationBatch>[
            MedicationBatch(
              id: 1,
              medicationId: 1,
              quantity: 5,
              initialQuantity: 10,
              expiresAt: DateTime(0),
            ),
            MedicationBatch(
              id: 2,
              medicationId: 1,
              quantity: 3,
              initialQuantity: 10,
              expiresAt: DateTime(0),
            ),
          ],
          isLoading: false,
          error: '',
        );
      },
      act: (MedicationsBloc bloc) => bloc.add(const DeleteMedication(0)),
      expect: () => <MedicationsState>[
        MedicationsState(
          medications: const <int, Medication>{1: Medication(id: 1, name: 'Existing Med')},
          batches: <MedicationBatch>[
            MedicationBatch(
              id: 2,
              medicationId: 1,
              quantity: 3,
              initialQuantity: 10,
              expiresAt: DateTime(0),
            ),
          ],
          isLoading: false,
          error: '',
        ),
      ],
    );

    blocTest<MedicationsBloc, MedicationsState>(
      'emits error if anything goes wrong',
      build: () => blocUnderTesting,
      setUp: () {
        when(() => discardMedicationBatchUseCase.execute(any())).thenThrow(Exception());
      },
      seed: () {
        return MedicationsState(
          medications: const <int, Medication>{
            1: Medication(id: 1, name: 'Existing Med'),
          },
          batches: <MedicationBatch>[
            MedicationBatch(
              id: 1,
              medicationId: 1,
              quantity: 5,
              initialQuantity: 10,
              expiresAt: DateTime(0),
            ),
          ],
          isLoading: false,
          error: '',
        );
      },
      act: (MedicationsBloc bloc) => bloc.add(const DeleteMedication(0)),
      expect: () => <MedicationsState>[
        MedicationsState(
          medications: const <int, Medication>{
            1: Medication(id: 1, name: 'Existing Med'),
          },
          batches: <MedicationBatch>[
            MedicationBatch(
              id: 1,
              medicationId: 1,
              quantity: 5,
              initialQuantity: 10,
              expiresAt: DateTime(0),
            )
          ],
          isLoading: false,
          error: 'Error while discarding medication',
        ),
      ],
    );
  });
}
