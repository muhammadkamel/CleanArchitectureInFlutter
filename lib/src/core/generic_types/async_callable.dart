import 'package:oth_app/src/core/generic_types/future_either_failure.dart';

import 'base_use_case.dart';

typedef AsyncCallable<ReturnType, InputType>
    = BaseUseCase<FutureEitherFailureOrType<ReturnType>, InputType>;
