abstract interface class UseCase<Input, Output> {
  Output execute(Input payload);
}

abstract interface class FutureUseCase<Input, Output> {
  Future<Output> execute(Input payload);
}

abstract interface class StreamUseCase<Input, Output> {
  Stream<Output> execute(Input payload);
}
