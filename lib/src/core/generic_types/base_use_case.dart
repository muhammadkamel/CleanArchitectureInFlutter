abstract class BaseUseCase<ReturnType, Params> {
  const BaseUseCase();
  ReturnType call(Params params);
}
